//
//  CoverPlayerView.swift
//  SleepTight
//
//  Created by Paula on 14/04/2022.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct CoverPlayerView: View {
  
  @State var song: Song
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16.0) {
      VStack{
        WebImage(url: URL(string: song.image))
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 144, height: 144)
          .cornerRadius(8)
          .shadow(color: Color(#colorLiteral(red: 0.019607841968536377, green: 0.0313725546002388, blue: 0.1568627506494522, alpha: 0.699999988079071)), radius:24, x:0, y:14)
      }
      
      VStack(alignment: .leading, spacing: 4.0) {
        Text(song.title)
          .font(.system(size: 15, weight: .semibold))
          .tracking(-0.5)
          .lineLimit(1)
        
        Text(song.author)
          .font(.system(size: 13, weight: .regular))
          .tracking(-0.08)
          .opacity(0.7)
          .lineLimit(1)
      }
    }
    .frame(width: 144)
  }
}



