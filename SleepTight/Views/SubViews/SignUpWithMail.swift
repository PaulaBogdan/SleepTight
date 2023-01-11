//
//  SignInWithMail.swift
//  SleepTight
//
//  Created by Paula on 18/07/2022.
//

import SwiftUI
import Firebase

struct SignUpWithMail: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var userInfo: UserInfo
  @ObservedObject var userVM: UserViewModel
  @State var logInPage: Bool = false
  @FocusState private var isNameFocused: Bool
  @FocusState private var isEmailFocused: Bool
  @FocusState private var isPasswordFocused: Bool
  @State var showErrors: Bool = false
  @State var showForgotView = false
  @State private var showAlert = false
  @State private var authError: EmailAuthError?
  @State var passwordVissible: Bool = false
  @Binding var showSignUpView: Bool
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        HStack {
          Button(action: {
            self.logInPage.toggle()
          }, label: {
            Text(logInPage ? "Create an account" : "Login")
              .font(.system(size: 15, weight: .semibold))
              .tracking(-0.5)
              .padding(.horizontal, 16.0)
              .padding(.vertical, 8.0)
              .background(Color.white.opacity(0.2))
              .cornerRadius(100)
          })
          
          Spacer()
          
          Button(action: {
            presentationMode.wrappedValue.dismiss()
            
          }, label: {
            Image(systemName: "xmark")
              .font(.system(size: 28, weight: .regular))
          })
        }
        .padding(.all, 16.0)
        
        Text(logInPage ? "Log in with email" : "Create an account")
          .font(.system(size: 34, weight: .bold))
          .tracking(0.37)
          .foregroundColor(.white)
          .padding(.bottom, 32.0)
        
        VStack(spacing: 16.0) {
          
          //MARK: sign up - user name
          if !logInPage {
            VStack(alignment: .leading, spacing: 4.0) {
              LoginFieldRowView(userText: $userVM.name, imageName: "person", placeholderText: "Name", focused: _isNameFocused, isPassword: false, passwordVissible: $passwordVissible)
                .focused($isNameFocused)
              
              if showErrors && userVM.name.isEmpty {
                Text(userVM.validNameText)
                  .font(.system(size: 15, weight: .regular))
                  .foregroundColor(Color("errorText"))
                  .tracking(-0.24)
              }
            }
          }
          
          //MARK: sign up - user mail
          VStack(alignment: .leading, spacing: 4.0) {
            LoginFieldRowView(userText: $userVM.email, imageName: "envelope", placeholderText: "Email", focused: _isEmailFocused, isPassword: false, passwordVissible: $passwordVissible)
              .focused($isEmailFocused)
            
            if !logInPage && showErrors && !userVM.isEmailValid(userVM.email) {
              ErrorText(text: userVM.validEmailAdressText)
            }
            
            if authError != nil && (authError == .invalidEmail  || authError == .accoundDoesNotExist) {
              ErrorText(text: self.authError?.errorDescription ?? "Unknow Error")
            }
          }
          
          //MARK: sign up - user name
          VStack(alignment: .leading, spacing: 4.0) {
            LoginFieldRowView(userText: $userVM.password, imageName: "lock", placeholderText: "Password", focused: _isPasswordFocused, isPassword: true,  passwordVissible: $passwordVissible, showEye: true)
              .focused($isPasswordFocused)
            
            if !logInPage && showErrors && !userVM.isPasswordValid(userVM.password) {
              ErrorText(text: userVM.validPasswordText)
            }
            
            if authError != nil && !(authError == .invalidEmail  || authError == .accoundDoesNotExist) {
              ErrorText(text: self.authError?.localizedDescription ?? "Unknow Error")
            }
          }
        }
        .padding(.horizontal, 24.0)
        
        Button(action: {
          if logInPage {
            login()
          } else {
            signUp()
          }
        }, label: {
          ZStack {
            RoundedRectangle(cornerRadius: 100)
              .fill(.white)
              .frame(width: UIScreen.main.bounds.width ,height: 56, alignment: .center)
            
            Text(logInPage ? "Log In" : "Sign Up")
              .font(.system(size: 17, weight: .semibold))
              .foregroundColor(Color(#colorLiteral(red: 0.02, green: 0.03, blue: 0.16, alpha: 1)))
              .tracking(-0.41)
          }
          .padding(.all, 24.0)
        })
        
        if !logInPage {
          ConditionsDescription()
        }
        
        if logInPage {
          Button(action: {
            showForgotView = true
          }, label: {
            Text("Forgot my password")
              .font(.system(size: 15, weight: .semibold))
              .tracking(-0.5)
              .padding(.horizontal, 16.0)
              .padding(.vertical, 8.0)
              .background(Color.white.opacity(0.2))
              .cornerRadius(100)
          })
        }
        
        Spacer()
      }
      .navigationBarHidden(true)
      .background(Color("background1"))
      .sheet(isPresented: $showForgotView) {
        ForgotPasswordView(userVM: userVM, showForgotView: $showForgotView)
      }
      Spacer()
    }
    .navigationViewStyle(.stack)
    .background(Color("background1"))
  }
  
  func login() {
    FBAuth.authenticate(withEmail: userVM.email, password: userVM.password) { (result) in
      switch result {
      case .failure(let error):
        authError = error
        showErrors = true
        print(error.localizedDescription)
      case .success:
        showSignUpView = false
      }
    }
  }
  
  func signUp() {
    if userVM.isEmpty(userVM.name) || !userVM.isPasswordValid(userVM.password) || !userVM.isEmailValid(userVM.email)  {
      showErrors = true
    } else {
      FBAuth.createUser(withEmail: userVM.email, name: userVM.name, password: userVM.password) { (result) in
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
          showErrors = true
        case .success:
          showSignUpView = false
        }
      }
    }
  }
}

struct SignUpWithMail_Previews: PreviewProvider {
  static var previews: some View {
    SignUpWithMail(userVM: UserViewModel(), showSignUpView: .constant(true))
      .environment(\.colorScheme, .dark)
  }
}


