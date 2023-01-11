//
//  AlertButton.swift
//  SleepTight
//
//  Created by Paula on 28/07/2022.
//

import SwiftUI

struct AlertButton: View {
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 100)
        .fill(.white)
        .frame(width: 246, height: 38, alignment: .center)
      
      Text("Great")
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(Color("background1"))
        .tracking(-0.41)
    }
  }
}

struct AlertButton_Previews: PreviewProvider {
  static var previews: some View {
    AlertButton()
  }
}
