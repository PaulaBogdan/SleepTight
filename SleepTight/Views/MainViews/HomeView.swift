////
////  HomwView.swift
////  SleepTight
////
////  Created by Paula on 09/04/2022.
////
////
import SwiftUI
import MinimizableView

struct HomeView: View {
  
  @ObservedObject var songVM : SongViewModel
  @ObservedObject var favoriteVM: FavoritesViewModel
  @ObservedObject var recentVM: RecentViewModel
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @EnvironmentObject var userInfo: UserInfo
  @Environment(\.presentationMode) var presentationMode
  @Binding var currentPlaylist: Playlist
  @Binding var currentSong: Song
  @Binding var showSettings: Bool
  @Binding var favoritePlaylist: Bool
  @State var varticalOffset: CGFloat = 0.0
  @State var horizontalOffset = CGSize.zero
  @State var indexOfPlaylist:Int = 0
  @State var choosenPlaylist: Playlist = Playlist(name: "", songs: [])
  
  
  var body: some View {
    GeometryReader { proxy in
      ZStack(alignment: .bottomLeading) {
        ScrollView(showsIndicators: false) {
          VStack(spacing: 32.0) {
            VStack(alignment: .leading, spacing: 0) {
              HStack(alignment: .center) {
                Text("\(Greeting().greetingLogic()),")
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
              
              HStack {
                Text(userInfo.user.name)
                  .font(.system(size: 34, weight: .bold))
                  .tracking(0.37)
              }
            }
            .padding(.trailing, 20.0)
            .padding(.top, 24)
            
            if recentVM.songs.count >= 1 {
              VStack(spacing: 20.0) {
                HStack {
                  Text("Recent played")
                    .font(.title2)
                    .fontWeight(.bold)
                    .tracking(0.35)
                  
                  Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                  HStack(alignment: .top, spacing: 20.0) {
                    ForEach(recentVM.songs.reversed()) { song in
                      CoverPlayerView(song: song)
                        .onTapGesture {
                          currentSong = song
                          favoritePlaylist = false
                          miniHandler.isPresented = true
                          miniHandler.isMinimized = true
                        }
                    }
                  }
                  
                }
              }
            }
            
            VStack(spacing: 22.0) {
              ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 26.0) {
                  ForEach(songVM.playlists) {
                    playlist in
                    VStack(alignment: .leading, spacing: 4.0) {
                      Text(playlist.name)
                        .font(choosenPlaylist == playlist ? .title2 : .footnote)
                        .fontWeight(choosenPlaylist == playlist ? .bold : .regular)
                        .foregroundColor(Color.white)
                      
                      if choosenPlaylist == playlist {
                        RoundedRectangle(cornerRadius: 30)
                          .fill(Color.white)
                          .frame(width: 20, height: 2)
                      }
                    }
                    .frame(height: 38)
                    .onTapGesture {
                      withAnimation {
                        choosenPlaylist = playlist
                      }
                    }
                  }
                  .onAppear {
                    choosenPlaylist = songVM.playlists.first!
                  }
                }
                .padding(.trailing, 20)
              }
              
              VStack {
                if songVM.playlists.first == nil {
                  EmptyView()
                } else {
                  VStack(alignment: .leading, spacing: 24.0) {
                    ForEach(choosenPlaylist.songs) {
                      song in
                      MusicRowView(song: song, favoriteVM: favoriteVM)
                        .onTapGesture {
                          currentSong = song
                          favoritePlaylist = false
                          miniHandler.isPresented = true
                          miniHandler.isMinimized = true
                        }
                    }
                  }
                  .padding(.bottom, 100.0)
                  .padding(.trailing, 20)
                  .gesture( DragGesture()
                    .onChanged { gesture in
                      _ = gesture.location.x
                      horizontalOffset = gesture.translation
                    }
                    .onEnded { _ in
                      withAnimation {
                        swipeAction()
                      }
                    }
                  )//gesture
                }
              }
            }
          }
        }
        .navigationBarHidden(true)
        .navigationTitle("Home")
        .padding(.leading, 20)
        .background(
          BackgroundImage()
        )
        .onAppear {
          recentVM.getUsersSongs()
        }
      }
    }
  }
  
  func swipeAction() {
    if horizontalOffset.width > 50 {
      if indexOfPlaylist > 0 {
        choosenPlaylist = songVM.playlists[indexOfPlaylist-1]
        self.indexOfPlaylist = indexOfPlaylist-1
      }
    } else if horizontalOffset.width < -50 {
      if indexOfPlaylist < 4 {
        choosenPlaylist = songVM.playlists[indexOfPlaylist+1]
        indexOfPlaylist = indexOfPlaylist+1
      }
    } else {
      horizontalOffset.width = .zero
    }
  }
}

