//
//  ErrorText.swift
//  SleepTight
//
//  Created by Paula on 17/11/2022.
//

import SwiftUI

struct ErrorText: View {
  
  var text: String
  
  var body: some View {
    Text(text)
      .font(.system(size: 15, weight: .regular))
      .foregroundColor(Color("errorText"))
      .tracking(-0.24)
  }
}

struct ErrorText_Previews: PreviewProvider {
  static var previews: some View {
    ErrorText(text: "error")
  }
}
