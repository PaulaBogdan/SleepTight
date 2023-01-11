//
//  HeartView.swift
//  SleepTight
//
//  Created by Paula on 09/07/2022.
////
//
import SwiftUI

struct HeartView: View {
  
  @State var song: Song
  @ObservedObject var favoriteVM: FavoritesViewModel
  
  var body: some View {
    VStack {
      Button(action: {
        favoriteVM.manageUsersSongs(songId: song.id)
        print("added song to favorites: \(favoriteVM.songsId)")
      }, label: {
        Image(systemName: favoriteVM.songsId.contains(song.id) ? "heart.fill" : "heart" )
          .foregroundColor(favoriteVM.songsId.contains(song.id) ? Color("primary") : Color(.white) )
          .opacity( favoriteVM.songsId.contains(song.id) ? 1.0 : 0.4)
          .font(.system(size: 24, weight: .medium))
      })//button
    }
  }
}
