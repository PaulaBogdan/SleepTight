//
//  LoginFieldRowView.swift
//  SleepTight
//
//  Created by Paula on 16/11/2022.
//

import SwiftUI

struct LoginFieldRowView: View {
  
  @Binding var userText: String
  var imageName: String = ""
  var placeholderText = ""
  @FocusState var focused: Bool
  var isPassword: Bool = false
  @Binding var passwordVissible: Bool
  var showEye: Bool = false
  
  var body: some View {
    HStack(spacing: 8.0) {
      Image(systemName: imageName)
        .font(.system(size: 20, weight: .semibold))
        .foregroundColor(.white.opacity(focused ? 1.0 : 0.5))
        .frame(width: 24, height: 24, alignment: .center)
        .padding(.leading, 16.0)
      
      if isPassword {
        if passwordVissible {
          textField
        } else {
          SecureField("", text: self.$userText)
            .placeholder(when: self.userText.isEmpty && !focused) {
              Text("Password (8+characters)").foregroundColor(.white.opacity(0.5))
            }
            .textContentType(.password)
            .autocapitalization(.none)
            .foregroundColor(.white)
            .accentColor(.white)
        }// passwordVissible
      } else {
        textField
      }// isPassword
      
      if isPassword && showEye {
        Image(systemName: passwordVissible ? "eye" : "eye.slash")
          .font(.system(size: 20, weight: .semibold))
          .frame(height: 24)
          .foregroundColor(.white.opacity( 0.5))
          .padding(.trailing, 16.0)
          .onTapGesture {
            passwordVissible.toggle()
          }
      }
    }//HStack row
    .frame(height: 56)
    .background(Color(focused ?  "focusButton" : "background2")
      .opacity(focused ? 0.6 : 1.0))
    .cornerRadius(6)
    .overlay(
      RoundedRectangle(cornerRadius: 6)
        .stroke(Color("primary").opacity(focused ?  1.0 : 0), lineWidth: 1)
    )
  }//body
  
  var textField: some View {
    TextField("", text: self.$userText)
      .placeholder(when: self.userText.isEmpty && !focused) {
        Text(placeholderText).foregroundColor(.white.opacity(0.5))
      }
      .textContentType(.givenName)
      .autocapitalization(.words)
      .foregroundColor(.white)
      .accentColor(.white)
  }
}

struct LoginFieldRowView_Previews: PreviewProvider {
  static var previews: some View {
    LoginFieldRowView(userText: .constant("paula"), isPassword: true, passwordVissible: .constant(false), showEye: true)
  }
}
