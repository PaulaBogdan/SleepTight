//
//  CategoryIndicator.swift
//  SleepTight
//
//  Created by Paula on 14/04/2022.
//

import SwiftUI

struct CategoryButton: View {
  
  @Binding var playlist: Playlist
  @Binding var selected: Bool
  
  var body: some View {
    
    VStack {
      Text(playlist.name)
        .font(selected ? .title2 : .footnote)
        .fontWeight(selected ? .bold : .regular)
        .foregroundColor(Color.white)
      if selected {
        RoundedRectangle(cornerRadius: 30)
          .fill(Color.white)
          .frame(width: 20, height: 2)
      }
    }
    .frame(height: 38)
  }
}
