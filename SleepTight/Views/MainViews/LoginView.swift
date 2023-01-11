//
//  LoginView.swift
//  SleepTight
//
//  Created by Paula on 18/07/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @EnvironmentObject var userInfo: UserInfo
  @ObservedObject var userVM = UserViewModel()
  @State private var signInWithAppleObject = SignInWithAppleButtonView()
  @State var showContent: Bool = false
  @State var currentNonce: String?
  @State var showSignUpView: Bool = false
  enum Action {
    case signUp, resetPW
  }
  
  var body: some View {
    NavigationView{
      
      ZStack {
        BackgroundImage()
        
        VStack {
          Spacer()
          
          HStack {
            Image("logo")
              .resizable()
              .scaledToFit()
              .frame(width: 224, height: 224, alignment: .center)
              .aspectRatio(contentMode: .fit)
              .cornerRadius(32)
          }
          .padding(.bottom, 32)
          
          VStack(spacing: 0.0) {
            Text("Sleep Tight Baby")
              .font(.system(size: 32, weight: .bold))
              .tracking(0.37)
            Text("Let your baby have a pleasant time \nwhile you have a pleasant sleep.")
              .font(.system(size: 15, weight: .regular))
              .tracking(-0.24)
              .multilineTextAlignment(.center)
              .padding(.top, 16.0)
            VStack {
            }.frame(minHeight: 60)
            
            VStack {
              Text("By continuing I agree with")
              
              HStack(spacing: 2.0) {
                Text("the")
                
                NavigationLink(destination: TermsAndConditionsView(isSheet: true).navigationBarHidden(true), label: {
                  Text("Terms & Conditions")
                    .underline()
                })
                Text("and")
                NavigationLink(destination: PrivacyPolicyView(isSheet: true).navigationBarHidden(true), label: {
                  Text("Privacy Policy")
                    .underline()
                })
              }
            }
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color.white.opacity(0.7))
          }
          .multilineTextAlignment(.center)
          
          SignInWithAppleButtonView()
            .padding(.vertical, 32)
            .padding(.horizontal, 8.0)
          
          HStack(spacing: 40.0) {
            LoginCircleButton(image: "google")
              .onTapGesture {
                handleLogin()
              }
            
            LoginCircleButton(isEnvelope: true, image: "envelope.fill")
              .onTapGesture {
                showSignUpView = true
              }
          }
          
          Spacer()
        }
        .padding(.all, 16.0)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showSignUpView) {
          SignUpWithMail(userVM: userVM, showSignUpView: $showSignUpView)
        }
      }
      .navigationBarHidden(true)
    }
    .navigationViewStyle(.stack)
  }
  
  func handleLogin(){
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { user, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      guard let authentication = user?.authentication,
            let idToken = authentication.idToken
      else {
        return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)
      
      Auth.auth().signIn(with: credential) { result, error in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        guard (result?.user) != nil else {
          return
        }
        let uid =  result?.user.uid ?? ""
        let name =  result?.user.displayName ?? ""
        let email = result?.user.email ?? ""
        let data = FBUser.dataDict(uid: uid,
                                   name: name,
                                   email: email, favoritesSongs: [], recentSongs: [])
        
        FBFirestore.mergeFBUser(data, uid: uid) { (result) in
        }
        userInfo.isUserAuthenticated = .signedIn
      }
    }
  }
}

extension View {
  func getRootViewController()-> UIViewController {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return .init()
    }
    guard let root = screen.windows.first?.rootViewController else {
      return .init()
    }
    return root
  }
}
