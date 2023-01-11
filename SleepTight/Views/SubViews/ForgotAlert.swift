//
//  ForgotAlert.swift
//  SleepTight
//
//  Created by Paula on 28/07/2022.
//

import SwiftUI

struct ForgotAlert: View {
  
  @Binding var showCustomAlert: Bool
  @Binding var showForgotView:Bool
  var password: Bool = false
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack {
      Spacer()
      
      HStack {
        Spacer()
      }
      
      VStack {
        VStack(spacing: 24.0) {
          Image(systemName: "checkmark.circle")
            .font(.system(size: 40, weight: .regular))
            .foregroundColor(Color("primary"))
          
          VStack(spacing: 8.0) {
            Text(password ? "Password updated!" : "Link sent!")
              .font(.system(size: 22, weight: .bold)).foregroundColor(.white)
              .tracking(0.35)
            
            Text(password ? "Your password has been successfully updated." : "You’ve got the link to rest your \n password. If you don’t see \n anything, check your Spam folder.").font(.system(size: 15, weight: .regular))
              .foregroundColor(.white.opacity(0.7))
              .tracking(-0.24)
              .multilineTextAlignment(.center)
              .lineSpacing(3.0)
          }
          
          ZStack {
            RoundedRectangle(cornerRadius: 100)
              .fill(.white)
              .frame(width: 246, height: 38, alignment: .center)
            
            Text("Great")
              .font(.system(size: 17, weight: .semibold))
              .foregroundColor(Color("background1"))
              .tracking(-0.41)
          }
          .onTapGesture {
            self.showCustomAlert = false
            self.showForgotView = false
            presentationMode.wrappedValue.dismiss()
          }
        }
        .padding(.all, 24.0)
      }
      .background(Color("background2"))
      .padding(.horizontal, 34.0)
      
      Spacer()
    }
    .background(.black.opacity(0.6))
  }
}

struct ForgotAlert_Previews: PreviewProvider {
  static var previews: some View {
    ForgotAlert(showCustomAlert: .constant(true), showForgotView: .constant(false), password: true)
  }
}
