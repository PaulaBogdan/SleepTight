////
////  SoundsView.swift
////  SleepTight
////
////  Created by Paula on 09/04/2022.
////

import SwiftUI
import MinimizableView

struct SearchView: View {
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @ObservedObject var songVM: SongViewModel
  @EnvironmentObject var audioManager: AudioManager
  @ObservedObject var recentVM: RecentViewModel
  @ObservedObject var favoriteVM: FavoritesViewModel
  @Environment(\.isSearching) private var isSearching
  @Binding var currentPlaylist: Playlist
  @Binding var currentSong: Song
  @Binding var showSettings: Bool
  @State var searchText: String = ""
  @State var isEditing = false
  @Binding var favoritePlaylist: Bool

  var body: some View {
    
    NavigationView {
      ZStack(alignment: .top) {
        BackgroundImage()
        
        VStack(spacing: 0) {
          HStack{}.frame(height: 24)
          
          ScrollView(showsIndicators: false) {
            
            HStack {
              Text("Search")
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
            .padding(.bottom, 16)
            
            VStack(spacing: 32) {
              SearchBar(text: $searchText, isEditing: $isEditing)
              
              if  searchText.isEmpty {
                VStack(alignment: .leading, spacing: 20.0) {
                  ForEach(recentVM.songs.reversed()) { song in
                    MusicRowView(song: song, favoriteVM: favoriteVM, isSearch: true)                                        .onTapGesture {
                      currentSong = song
                      favoritePlaylist = false
                      miniHandler.isPresented = true
                      miniHandler.isMinimized = true
                    }
                  }
                }
              } else {
                VStack {
                  ForEach(songVM.songs.filter({
                    searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased()) || $0.author.lowercased().contains(searchText.lowercased())
                  })) { item in
                    MusicRowView(song: item, favoriteVM: favoriteVM, isSearch: true)
                      .onTapGesture {
                        currentSong = item
                        miniHandler.isPresented = true
                        miniHandler.isMinimized = true
                      }
                  }
                }
              }
            }
            .padding(.bottom, 100.0)
            
            Spacer()
          }
        }
        .padding(.horizontal, 20)
      }
      .navigationBarHidden(true)
    }
  }
}


struct SearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    PreviewWrapper()
      .previewInterfaceOrientation(.portrait)
  }
  
  struct PreviewWrapper: View {
    @State(initialValue: Playlist(name: "fffdfv", songs: [Song( image: "logo", title: "ffdfffdf", author: "ddfvfddfdf", track: "")])) var currentPlaylist: Playlist
    @State(initialValue: Song(image: "logo", title: "dfdfggg", author: "nn", track: "")) var currentSong: Song
    @State(initialValue: [Song(image: "logo", title: "ccbvdv", author: "xvvbb", track: "")]) var recentSongsObj: [Song]
    
    var body: some View {
      SearchView(songVM: SongViewModel(songRepo: SongRepository()), recentVM: RecentViewModel(songRepo: SongRepository()), favoriteVM: FavoritesViewModel(songRepo: SongRepository()), currentPlaylist: $currentPlaylist, currentSong: $currentSong, showSettings: .constant(false), favoritePlaylist: .constant(false))
        .environment(\.colorScheme, .dark)
        .environmentObject(SongViewModel(songRepo: SongRepository()))
        .environmentObject(AudioManager())
        .environmentObject(RecentViewModel(songRepo: SongRepository()))
        .environmentObject(FavoritesViewModel(songRepo: SongRepository()))
      
    }
  }
}

