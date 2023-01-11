//
//  SearchBar.swift
//  SleepTight
//
//  Created by Paula on 09/09/2022.
//

import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  @Binding  var isEditing: Bool
  
  var body: some View {
    VStack(spacing: 0.0) {
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(.white)
        
        TextField(isEditing ? "" : "Search for music", text: $text)
          .foregroundColor(.white)
          .onTapGesture {
            withAnimation {
              self.isEditing = true
            }
          }
        
        if isEditing || !text.isEmpty{
          Button(action: {
            withAnimation {
              self.isEditing = false
              self.text = ""
            }
          }, label: {
            Image(systemName: "xmark")
              .foregroundColor(.white)
          })
        }
      }//HStack row
      .padding(.horizontal, 16.0)
      .padding(.vertical, 10.0)
    }//component
    .frame(height: 44)
    .background(Color("background1"))
    .cornerRadius(6)
  }
}

struct SearchBar_Previews: PreviewProvider {
  
  
  static var previews: some View {
    PreviewWrapper()
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: "") var text: String
    var body: some View {
      SearchBar(text: $text, isEditing: .constant(false))
    }
  }
}
