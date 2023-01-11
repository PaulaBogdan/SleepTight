//
//  GoogleReauthenticationButton.swift
//  SleepTight
//
//  Created by Paula on 10/01/2023.
//

import SwiftUI

struct GoogleReauthenticationButton: View {
    var body: some View {
        Button(action: {
          
        }, label: {
          ZStack {
            RoundedRectangle(cornerRadius: 100)
              .foregroundColor(.white)
            
            HStack {
              LoginCircleButton(isReauthentication: true, image: "google")
              
              Text("Continue with Google")
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(.black)
                .tracking(-0.41)
              
            }
          }
          
      })
        .frame(width: UIScreen.main.bounds.width-40, height: 54)
      }
    
    
}

struct GoogleReauthenticationButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleReauthenticationButton()
        .preferredColorScheme(.dark)
    }
}
