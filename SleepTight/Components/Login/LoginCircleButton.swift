//
//  LoginCircleButton.swift
//  SleepTight
//
//  Created by Paula on 18/07/2022.
//

import SwiftUI

struct LoginCircleButton: View {
  
  var isEnvelope: Bool = false
  var isReauthentication: Bool = false
  var image: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100)
        .fill(.white.opacity(0.2))
        .frame(width: isReauthentication ? 28 : 56, height: isReauthentication ? 28 : 56)
      
      if isEnvelope == true {
        Image(systemName: image)
          .frame(width: 28, height: 28, alignment: .center)
      } else {
        Image(image)
          .resizable()
          .scaledToFit()
          .frame(width: isReauthentication ? 14: 28, height: isReauthentication ? 14: 28, alignment: .center)
      
          .if(isReauthentication) { view in
            view.colorInvert()
          }
      }
    }
  }
}

struct LoginCircleButton_Previews: PreviewProvider {
  static var previews: some View {
    LoginCircleButton(isEnvelope: false, isReauthentication: true, image: "google")
//      .preferredColorScheme(.dark)
  }
}


extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
