//
//  ChangePassword.swift
//  SleepTight
//
//  Created by Paula on 20/09/2022.
//

import SwiftUI
import Firebase


struct ChangePassword: View {
  @Environment(\.presentationMode) var presentationMode
  @State var currentPassword: String = ""
  @State var newPassword: String = ""
  @State var confirmNewPassword: String = ""
  @FocusState private var currentPasswordFocused: Bool
  @FocusState private var newPasswordFocused: Bool
  @FocusState private var confirmPasswordFocused: Bool
  @State var showErrors: Bool = false
  @State private var showCustomAlert = false
  @State var passwordVissible: Bool = false
  @State var newPasswordVissible: Bool = false
  @State var confirmPasswordVissible: Bool = false
  @State var incorrectPassword: Bool = false
  @State var showForgotView: Bool = false
  @Binding var showSettings: Bool
  
  var body: some View {
    ZStack {
      VStack(alignment: .center, spacing: 24.0) {
        Text("Change my password")
          .font(.system(size: 34, weight: .bold))
          .foregroundColor(.white)
        
        Text("To protect your account, create a password at least 8 characters long")
          .font(.system(size: 15, weight: .regular))
          .foregroundColor(.white.opacity(0.7))
          .tracking(-0.24)
          .multilineTextAlignment(.center)
        
        VStack(alignment: .leading, spacing: 16.0) {
          VStack(alignment: .leading, spacing: 4.0) {
            Text("Current Password")
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(.white)
              .tracking(-0.24)
            
            LoginFieldRowView(userText: $currentPassword, imageName: "lock", placeholderText: "Password", focused: _currentPasswordFocused, isPassword: true,  passwordVissible: $passwordVissible, showEye: true)
              .focused($currentPasswordFocused)
            
            if incorrectPassword {
              ErrorText(text: "Current password is incorrect")
            }
          }
          
          VStack(alignment: .leading, spacing: 4.0) {
            Text("New Password")
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(.white)
              .tracking(-0.24)
            
            LoginFieldRowView(userText: $newPassword, imageName: "lock", placeholderText: "Password", focused: _newPasswordFocused, isPassword: true,  passwordVissible: $passwordVissible)
              .focused($newPasswordFocused)
            
            if showErrors {
              if !self.isPasswordValid(password: self.newPassword) {
                ErrorText(text: "Use at least 8 characters")
              }
              if newPassword == currentPassword {
                ErrorText(text: "New password cannot be the same as old password")
              }
              if newPassword != confirmNewPassword {
                ErrorText(text: "Passwords don't match")
              }
            }
          }
          
          VStack(alignment: .leading, spacing: 4.0) {
            Text("Confirm Password")
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(.white)
              .tracking(-0.24)
            
            LoginFieldRowView(userText: $confirmNewPassword, imageName: "lock", placeholderText: "Password", focused: _confirmPasswordFocused, isPassword: true,  passwordVissible: $passwordVissible)
              .focused($confirmPasswordFocused)
          }
        }
        Button(action: {
          self.changePassword()
        } , label: {
          ZStack {
            RoundedRectangle(cornerRadius: 100)
              .fill(.white)
              .frame(width: .infinity, height: 56, alignment: .center)
            
            Text("Save")
              .font(.system(size: 17, weight: .semibold))
              .foregroundColor(Color(#colorLiteral(red: 0.02, green: 0.03, blue: 0.16, alpha: 1)))
              .tracking(-0.41)
          }
        })
        
        Spacer()
      }
      .padding(.horizontal, 24.0)
      
      if showCustomAlert {
        ForgotAlert(showCustomAlert: $showCustomAlert, showForgotView: $showSettings, password: true)
      }
    }
    .background(Color("background1"))
  }
  
  func isPasswordValid(password: String) -> Bool {
    let passwodTest = NSPredicate(format: "Self matches %@", ".{8,}")
    return passwodTest.evaluate(with: password)
  }
  
  func changePassword() {
    if  !self.isPasswordValid(password: self.newPassword) || !self.isPasswordValid(password: self.confirmNewPassword) || newPassword == currentPassword  || newPassword != confirmNewPassword{
      showErrors = true
    } else {
      FBAuth.reauthenticateWithPassword(password: self.currentPassword) { (result) in
        switch result {
        case .failure(let error):
          //                                self.showErrors = true
          self.incorrectPassword = true
          print(error.localizedDescription)
        case .success:
          print("Signed in")
          
          let currentUser = Auth.auth().currentUser
          
          if self.isPasswordValid(password: self.newPassword)  {
            currentUser?.updatePassword(to: self.newPassword) { error in
              if let error = error {
                print(error)
              }
              self.showCustomAlert = true
            }
          } else {
            showErrors = true
          }
        }
      }//FBAuth reauthentication
    }
  }//changePassword()
}




struct ChangePassword_Previews: PreviewProvider {
  static var previews: some View {
    ChangePassword(showSettings: .constant(false))
  }
}
