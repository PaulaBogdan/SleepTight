//
//  ReauthenticationView.swift
//  SleepTight
//
//  Created by Paula on 20/09/2022.
//

import SwiftUI
import MinimizableView
import FirebaseAuth
import GoogleSignIn
import Firebase

struct ReauthenticationView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @EnvironmentObject var userInfo: UserInfo
  @ObservedObject var userVM: UserViewModel
  @Binding var providers: [FBAuth.ProviderType]
  @FocusState private var isPasswordFocused: Bool
  @State var password = ""
  @State var errorText = ""
  @State var showLoginWithPassword: Bool = false
  @State var loading: Bool = false
  @State var passwordVissible: Bool = false
  @State var showErrors: Bool = false
  
  var body: some View {
    ZStack {
      Color("background1")
      
      VStack(alignment: .center, spacing: 12.0) {
        VStack(spacing: 24.0) {
          Text("Delete account")
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.white)
            .tracking(0.37)
          
          VStack(spacing: 8.0) {
            Text("You are logged as \(Auth.auth().currentUser?.email ?? "")")
              .font(.system(size: 15, weight: .bold))
            
            Text("Deleting account remove all information \n and content from database. ")
            +
            Text("This action cannot be reversed.")
              .font(.system(size: 15, weight: .bold))
          }
          .font(.system(size: 15, weight: .regular))
          .foregroundColor(.white)
        }
        .padding(.top, 24.0)
        .multilineTextAlignment(.center)
        
        Spacer()
       
          
        VStack(spacing: 5) {
            if providers.contains(.apple) {
              SignInWithAppleButtonView(handleResult: handleResult)
            } else if providers.contains(.google) {
              GoogleReauthenticationButton()
            } else {
              
               HStack(spacing: 12.0){
                 Button(action: {
                   presentationMode.wrappedValue.dismiss()
                 }, label: {
                   ZStack {
                     RoundedRectangle(cornerRadius: 100)
                       .stroke()
                       .frame(height: 56, alignment: .center)
                     
                     Text("Cancel")
                       .font(.system(size: 17, weight: .semibold))
                       .foregroundColor(.white)
                       .tracking(-0.41)
                   }
                 })
               }
//              VStack {
//                Button(action: {
//                  //            if providers == [.apple] {
//                  //              showAppleButton = true
//                  //            }
//                  //            if providers == [.google] {
//                  //              loading = true
//                  //              googleLogin()
//                  //            }
//                  //            if providers == [.password] {
//                  //              showLoginWithPassword = true
//                  //            }
//                }, label: {
//                  ZStack {
//                    RoundedRectangle(cornerRadius: 100)
//                      .fill(Color.white)
//                      .frame(height: 56, alignment: .center)
//
//                    Text("Authenticate")
//                      .font(.system(size: 17, weight: .semibold))
//                      .foregroundColor(Color.black)
//                      .tracking(-0.41)
//                  }
//                })
//              }
            }
            
            
            
          }
          
          
        }
        .padding(.vertical, 48.0)
    
      
//      if showLoginWithPassword {
//        VStack(alignment: .center, spacing: 8.0) {
//          LoginFieldRowView(userText: $password, imageName: "lock", placeholderText: "Password", focused: _isPasswordFocused, isPassword: true,  passwordVissible: $passwordVissible, showEye: true)
//            .focused($isPasswordFocused)
//
//          if showErrors && !userVM.isPasswordValid(password) {
//            ErrorText(text: userVM.validPasswordText)
//          }
//
//          Button(action: {
//            FBAuth.reauthenticateWithPassword(password: password) { result in
//              handleResult(result: result)
//            }
//          }, label: {
//            ZStack {
//              RoundedRectangle(cornerRadius: 100)
//                .fill(Color("errorText"))
//                .frame(width: 150, height: 56, alignment: .center)
//
//              Text("Delete")
//                .font(.system(size: 17, weight: .semibold))
//                .foregroundColor(.white)
//                .tracking(-0.41)
//            }
//          })
//          .disabled(password.isEmpty)
//        }
//      }
    }
    .padding(.horizontal, 20)
    .background(Color("background1"))
    .onAppear {
      providers = FBAuth.getProviders()
    }
  }
  
  // Handle if authorization is success to delete account
  func handleResult(result: Result<Bool, Error>) {
    switch result {
    case .success:
      deleteUserData()
      presentationMode.wrappedValue.dismiss()
    case .failure(let error):
      errorText = error.localizedDescription
    }
  }
  
  func googleLogin() {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
   
    // Create Google Sign In configuration object.
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
      
      if let user = Auth.auth().currentUser {
        user.reauthenticate(with: credential) { _, error in
          if let error = error {
            print(error)
          } else {
            deleteUserData()
          }
        }
      }
    }
  }
  
  func deleteUserData() {
    FBFirestore.deleteUserData(uid: userInfo.user.uid) { result in
      switch result {
      case .success:
        FBAuth.deleteUser { (result) in
          if case let .failure(error) = result {
            print(error.localizedDescription)
          }
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

struct ReauthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    ReauthenticationView(userVM: UserViewModel(), providers: .constant([.google, .apple]), showLoginWithPassword: false)
  }
}
