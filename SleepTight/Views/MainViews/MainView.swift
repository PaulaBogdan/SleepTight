////
////  TabView.swift
////  SleepTight
////
////  Created by Paula on 19/07/2022.
//
import SwiftUI
import Firebase
import MinimizableView


struct MainView: View {
  @StateObject var songVM : SongViewModel
  @StateObject private var audioManager = AudioManager()
  @StateObject var favoriteVM : FavoritesViewModel
  @StateObject var recentVM : RecentViewModel
  @EnvironmentObject var userInfo: UserInfo
  @State var currentSong: Song = Song(image: "", title: "", author: "", track: "")
  @State var currentPlaylist: Playlist = Playlist(name: "", songs: [])
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @Environment(\.presentationMode) var presentationMode
  @GestureState var dragOffset = CGSize.zero
  @State var showSettings: Bool = false
  @State var showLoading: Bool = false
  @State var favoritePlaylist = false

  init(songRepo: SongRepository) {
    _songVM = StateObject(wrappedValue: SongViewModel(songRepo: songRepo))
    _recentVM = StateObject(wrappedValue: RecentViewModel(songRepo: songRepo))
    _favoriteVM = StateObject(wrappedValue: FavoritesViewModel(songRepo: songRepo))

  }
  
  var body: some View {
    
    GeometryReader { proxy in
      ZStack {
        TabView {
          HomeView(songVM: songVM, favoriteVM: favoriteVM, recentVM: recentVM, currentPlaylist: $currentPlaylist, currentSong: $currentSong, showSettings: $showSettings, favoritePlaylist: $favoritePlaylist)
            .tabItem {
              Image(systemName: "house")
              Text("Home")
            }
          SearchView(songVM: songVM, recentVM: recentVM, favoriteVM: favoriteVM, currentPlaylist: $currentPlaylist, currentSong: $currentSong, showSettings: $showSettings, favoritePlaylist: $favoritePlaylist)
            .tabItem {
              Image(systemName: "magnifyingglass")
              Text("Search")
            }
          FavoritesView(songVM: songVM, favoriteVM: favoriteVM, currentSong: $currentSong, currentPlaylist: $currentPlaylist, showSettings: $showSettings, favoritePlaylist: $favoritePlaylist)
            .tabItem {
              Image(systemName: "heart")
              Text("Favorites")
            }
        }
        .accentColor(Color("primary"))
        .ignoresSafeArea(.all)
        .onAppear {
          guard let uid = Auth.auth().currentUser?.uid else {
            return
          }
          FBFirestore.retrieveFBUser(uid: uid) { (result) in
            switch result {
            case.failure(let error):
              print(error.localizedDescription)
            case .success(let user):
              userInfo.user = user
            }
          }
        }
        .onChange(of: currentSong) { _ in
          recentVM.manageUsersSongs(songId: currentSong.id)
          recentVM.getUsersSongs()
        }
        .statusBar(hidden: miniHandler.isPresented && miniHandler.isMinimized == true)
        .minimizableView(
          content: { AnyView(
            PlayerView(songVM: songVM, favoriteVM: favoriteVM,song: $currentSong, playlist: $currentPlaylist, showLoading: $showLoading, favoritePlaylist: $favoritePlaylist)
              .environmentObject(audioManager)
          ) },
          compactView: {
            EmptyView()
          },backgroundView: {
            backgroundView()
          }, dragOffset: $dragOffset,
          dragUpdating: { (value, state, transaction) in
            state = value.translation
            dragUpdated(value: value)
            
          } ,dragOnChanged: { (value) in
            dragOnChanged(value: value)
          }, dragOnEnded: { (value) in
            dragOnEnded(value: value)
          }, geometry: proxy, settings: MiniSettings(minimizedHeight: 80))
        .environmentObject(miniHandler)
        
        ProfileView(showSettings: $showSettings)
          .offset(x: showSettings ? 0 : 500)
          .environmentObject(audioManager)
       
        if showLoading {
          LoadingScreen()
        }
      }
    }
  }
  
  func dragOnChanged(value: DragGesture.Value) {
    if miniHandler.isMinimized == false && value.translation.height > 0 { // expanded state
     miniHandler.draggedOffsetY = value.translation.height / 2
    } else if miniHandler.isMinimized && value.translation.height < 0 { // minimized state
      miniHandler.draggedOffsetY = value.translation.height / 2
    }
  }
  
  func dragOnEnded(value: DragGesture.Value) {
    if miniHandler.isMinimized == false && value.translation.height > 60 {
      miniHandler.minimize()
    } else if miniHandler.isMinimized &&  value.translation.height < -60 {
      miniHandler.expand()
    }
    withAnimation(.spring()) {
      miniHandler.draggedOffsetY = 0
    }
  }
  func dragUpdated(value: DragGesture.Value) {
    if miniHandler.isMinimized == false && value.translation.height > 0 { // expanded state
      miniHandler.draggedOffsetY = value.translation.height
    } else if miniHandler.isMinimized && value.translation.height < 0 { // minimized state
      miniHandler.draggedOffsetY = value.translation.height
    }
  }
  
  func backgroundView() -> some View {
    VStack(spacing: 0){
      if miniHandler.isMinimized {
        Color(#colorLiteral(red: 0.02111111581325531, green: 0.032789602875709534, blue: 0.15833333134651184, alpha: 1))
      } else {
        BackgroundImage()
      }
    }
    .onTapGesture {
      if miniHandler.isMinimized {
        miniHandler.expand()
      }
    }
  }
}
