//
//  MusicRowView.swift
//  SleepTight
//
//  Created by Paula on 24/04/2022.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct MusicRowView: View {
  
  @State var song: Song
  @ObservedObject var favoriteVM: FavoritesViewModel
  var isSearch: Bool = false
  
  var body: some View {
    
    HStack(spacing: 20.0) {
      VStack {
        WebImage(url: URL(string: song.image))
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 64, height: 64)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .shadow(color: Color(#colorLiteral(red: 0.019607841968536377, green: 0.0313725546002388, blue: 0.1568627506494522, alpha: 0.699999988079071)), radius:24, x:0, y:14)
      }
      .frame(width: 64, height: 64)
      
      HStack {
        VStack(alignment: .leading, spacing: 4.0){
          Text(song.title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .lineLimit(1)
          Text(song.author)
            .font(.footnote)
            .opacity(0.7)
            .lineLimit(1)
        }
        Spacer()
        
        if isSearch {
          Image(systemName: "play.fill" )
            .foregroundColor(Color("primary"))
            .opacity(1.0)
            .font(.system(size: 24, weight: .medium))
        } else {
          HeartView(song: song, favoriteVM: favoriteVM)
        }
      }
      .foregroundColor(.white)
    }
  }
}

