//
//  ForgotPasswordView.swift
//  SleepTight
//
//  Created by Paula on 25/07/2022.
//

import SwiftUI

struct ForgotPasswordView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var userInfo: UserInfo
  @ObservedObject var userVM: UserViewModel
  @FocusState private var emailIsFocused: Bool
  @State private var showAlert = false
  @State private var showCustomAlert = false
  @State private var errString: String?
  @Binding var showForgotView:Bool
  @State var passwordVissible: Bool = false
  
  var body: some View {
    ZStack {
      VStack(alignment: .center) {
        HStack {
          Spacer()
          
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }, label: {
            Image(systemName: "xmark")
              .font(.system(size: 28, weight: .regular))
          })
        }
        
        VStack {
          Text("Password reset")
            .font(.system(size: 34, weight: .bold))
            .tracking(0.37)
            .padding(.top, 12.0)
          
          Text("You’ll get the email with a password reset link")
            .font(.system(size: 15, weight: .regular))
            .tracking(-0.24)
            .padding(.top, 8.0)
        }
        .foregroundColor(.white)
        
        VStack {
          LoginFieldRowView(userText: $userVM.email, imageName: "envelope", placeholderText: "Email", passwordVissible: $passwordVissible)
            .focused($emailIsFocused)
          
          if !userVM.validEmailAdressText.isEmpty {
            Text(userVM.validEmailAdressText)
              .font(.system(size: 15, weight: .regular))
              .foregroundColor(Color("errorText"))
              .tracking(-0.24)
          }
        }
        .padding(.top, 32.0)
        
        Button(action: {
          FBAuth.resetPassword(email: userVM.email) { (result) in
            switch result {
            case .failure(let error):
              showAlert = true
              errString = error.localizedDescription
            case .success:
              showCustomAlert = true
              break
            }
          }
        }, label: {
          ZStack {
            RoundedRectangle(cornerRadius: 100)
              .fill(.white)
              .frame(width: .infinity, height: 56, alignment: .center)
            
            Text("Get a password link")
              .font(.system(size: 17, weight: .semibold))
              .foregroundColor(Color(#colorLiteral(red: 0.02, green: 0.03, blue: 0.16, alpha: 1)))
              .tracking(-0.41)
          }
          .padding([.top, .leading, .trailing], 24.0)
        })
        
        Spacer()
      }
      .padding(.horizontal, 24.0)
      .background(Color("background1"))
      .alert("\(errString ?? "unknown error")" , isPresented: $showAlert) {
        Button("OK", role: .cancel){}
      }
      if showCustomAlert {
        ForgotAlert(showCustomAlert: $showCustomAlert, showForgotView: $showForgotView)
      }
    }
  }
}

