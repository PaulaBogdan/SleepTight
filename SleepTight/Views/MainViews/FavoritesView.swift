//
//  LibraryView.swift
//  SleepTight
//
//  Created by Paula on 13/04/2022.
//

import SwiftUI
import MinimizableView

struct FavoritesView: View {
  @ObservedObject var songVM: SongViewModel
  @EnvironmentObject var userInfo: UserInfo
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @ObservedObject var favoriteVM: FavoritesViewModel
  @Binding var currentSong: Song
  @Binding var currentPlaylist: Playlist
  @Binding var showSettings: Bool
  @Binding var favoritePlaylist: Bool

  var body: some View {
    
    ZStack(alignment: .top) {
      BackgroundImage()
      
      ScrollView(showsIndicators: false) {
        HStack {
          Text("Favorites")
            .font(.system(size: 34, weight: .bold))
            .tracking(0.37)
          
          Spacer()
          
          Button(action: {
            withAnimation {
              showSettings = true
            }
          }, label:  {
            Image(systemName: "person.circle")
              .font(.system(size: 28, weight: .regular))
              .foregroundColor(.white)
          })
        }
        .padding(.top, 24)
        
        VStack(spacing: 24.0) {
          ForEach(self.favoriteVM.songs) {
            song in
            MusicRowView(song: song, favoriteVM: favoriteVM)
              .onTapGesture {
                self.currentSong = song
                favoritePlaylist = true
                miniHandler.isPresented = true
                miniHandler.isMinimized = true
              }
          }
        }
        .padding(.bottom, 100.0)
      }
      .padding(.horizontal, 20.0)
    }
    .onChange(of: favoriteVM.songsId.count) { _ in
      withAnimation {
        favoriteVM.getUsersSongs()
      }
    }
  }
}


