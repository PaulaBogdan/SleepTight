//
//  SettingsRowView.swift
//  SleepTight
//
//  Created by Paula on 08/11/2022.
//

import SwiftUI

struct SettingsRowView: View {
  
  let imageName: String
  let text: String
  var color: Color = Color(.white)
  
  var body: some View {
    HStack(spacing: 16.0){
      Image(systemName: imageName)
        .foregroundColor(color)
        .frame(width: 22, height: 22, alignment: .center)
      
      Text(text)
        .font(.system(size: 17, weight: .regular))
        .tracking(-0.41)
        .foregroundColor(color)
      
      Spacer()
    }
    .listRowBackground(Color("background2"))
  }
}

struct SettingsRowView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsRowView(imageName: "shield", text: "Privacy Policy")
  }
}
