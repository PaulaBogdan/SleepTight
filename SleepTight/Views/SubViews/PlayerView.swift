//
//  PlayerView.swift
//  SleepTight
//
//  Created by Paula on 22/04/2022.
//

import SwiftUI
import Firebase
import AVFoundation
import SDWebImageSwiftUI
import MinimizableView


struct PlayerView: View {
  
  @ObservedObject var songVM: SongViewModel
  @ObservedObject var favoriteVM: FavoritesViewModel
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @EnvironmentObject var audioManager: AudioManager
  @Binding var song: Song
  @Binding var playlist: Playlist
  @State var width: CGFloat = 0
  @State var timerIsActive = false
  @State var isCompletion: Bool = false
  @State var showTimePicker: Bool = false
  @State var selectedTime = 5*60
  @State var fadeTimer: Timer?
  @State var playlistName  =  ""
  @State var playlistIndex  = 0
  @State var songIndex  =  0
  @State var horizontalOffset = CGSize.zero
  @Binding var showLoading: Bool
  @Binding var favoritePlaylist: Bool

  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    GeometryReader { proxy in
      VStack(alignment: .center, spacing: 0) {
        if miniHandler.isMinimized == false {
          playerTopBar
            .padding(.top, 60)
          
          VStack {
            if timerIsActive {
              ZStack {
                RoundedRectangle(cornerRadius: 100)
                  .fill(Color("background1").opacity(0.7))
                  .frame(width: 113, height: 37)
                  .padding(.vertical, 18.0)
                
                HStack {
                  Image(systemName: "timer")
                    .font(.system(size: 24, weight: .regular))
                    .opacity(0.2)
                  
                  timerText
                }
              }
            }
          }
          .frame(height: 70.0)
        }
        
        ZStack(alignment: .topTrailing) {
            HStack(alignment: .center) {
              WebImage(url: URL(string: song.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: miniHandler.isMinimized ? 48 : 256, height: miniHandler.isMinimized ? 48 : 256)
                .mask(RoundedRectangle(cornerRadius: miniHandler.isMinimized ? 4 : 24))
                .shadow(color: Color(#colorLiteral(red: 0.019607841968536377, green: 0.0313725546002388, blue: 0.1568627506494522, alpha: 0.699999988079071)), radius:24, x:0, y:14)
                .id(song.id)
                .gesture(miniHandler.isMinimized ? nil : drag )
              
              if miniHandler.isMinimized {
                HStack {
                  SongDescription(title: song.title, author: song.author)
                    .padding(.trailing, 16)
                }
                
                Spacer()
                
                HStack(spacing: 24.0) {
                  ZStack(alignment: .bottom) {
                    Image(systemName: "timer")
                      .font(.system(size: 26, weight: .regular))
                      .frame(width: 33, height: 48, alignment: .center)
                      .foregroundColor( timerIsActive ? Color("primary") : .white)
                    
                    Circle()
                      .fill(
                        Color("primary").opacity(timerIsActive ? 1 : 0))
                      .frame(width: 4, height: 4)
                  }
                  
                  Button(action: {
                    audioManager.playPause()
                  }, label: {
                    Image(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill")
                      .font(.system(size: 28, weight: .regular))
                      .foregroundColor(.white)
                      .frame(width: 24, height: 33)
                  })
                }
              }
            }
            .padding(.top, miniHandler.isMinimized ? 8.0 : 0)
            .padding(.trailing, miniHandler.isMinimized ? 16.0 : 0)
          
          if timerIsActive && miniHandler.isMinimized  {
              timerText
                .frame(width: 80, height: 16, alignment: .top)
                .padding(.trailing, 40)
          }
        }
        
        if miniHandler.isMinimized  {
          progressMiniPlayer
        } else {
          SongDescription(alignmentStack: .center, alignmentText: .center, spacing: 8.0, title: song.title, author: song.author, fontTitle: .title , fontAuthor: .body , tracking: 0.38, fontWeight: .bold, opacity: 1)
            .padding(.top, 60.0)
            .padding(.bottom, 32.0)
          
          expandedControls
        }
      }
      .frame(height: miniHandler.isMinimized ? 68 : UIScreen.main.bounds.height, alignment: .bottom)
      .padding(.horizontal, 20)
      .fullScreenCover(isPresented: $showTimePicker) {
        ZStack{
          Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
          TimerView(selectedTime: $selectedTime, timerIsActive: $timerIsActive)
        }
      }
    }
    .transition(AnyTransition.move(edge: .bottom))
    .onAppear {
      openPlayer()
    }
    .onChange(of: song) { newValue in
      newSong()
    }
  }
  
// Top bar in full screen player
  var playerTopBar: some View {
    HStack {
      Button(action: {
        miniHandler.minimize()
      }, label: {
        Image(systemName: "control")
          .font(.system(size: 28))
          .rotationEffect(Angle(degrees: 180))
          .frame(width: 33, height: 33, alignment: .center)
      })
      Spacer()
      
      Text(playlistName)
        .font(.callout)
      
      Spacer()
      
      HeartView(song: song, favoriteVM: favoriteVM)
    }
  }
  
//Progress bar for mini player
  var progressMiniPlayer: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white.opacity(0.2))
        .frame(width: UIScreen.main.bounds.width-40, height: 2)
      
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .frame(width: self.width, height: 2)
    }
    .padding(.top, 6.0)
    .padding(.bottom, 2.0)
  }
  
  // Swiping to change song with gestrue
  var drag: some Gesture {
    DragGesture()
      .onChanged { gesture in
        horizontalOffset = gesture.translation
      }
      .onEnded { _ in
        withAnimation {
          if horizontalOffset.width > 50 {
            previousSong()
            audioManager.playSong(song: song)
          } else if horizontalOffset.width < -50 {
            nextSong()
            audioManager.playSong(song: song)
          } else {
            horizontalOffset.width = .zero
          }
        }
      }
  }
  
  var timerText: some View {
    Text(audioManager.convertTime(timeInSeconds: selectedTime))
      .font(.system(size: 13, weight: .medium))
      .tracking(-0.08)
      .onReceive(timer) { time in
        if selectedTime > 0 {
          selectedTime -= 1
        }
        if selectedTime == 60 {
          fadeTimer = audioManager.fadeVolume(to: 0, duration: 60, completion: {
            timerIsActive = false
            timer.upstream.connect().cancel()
          })
        }
      }
  }
  
  var expandedControls: some View {
    VStack(alignment: .center) {
      VStack {
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.white.opacity(0.2))
            .frame(height: 4)
          
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(width: 14, height: 4)
          
          ZStack(alignment: .trailing){
            
            Circle()
              .fill(Color.white)
              .frame(width: 28, height: 28)
              .offset(x: 14)
            
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.white)
              .frame(width: self.width, height: 4)
          }
          .frame(width: self.width, height: 4)
          .gesture(DragGesture()
            .onChanged({ (value) in
              let x = value.location.x
              width = x
            }).onEnded( { (value) in
              if let duration = audioManager.player.currentItem?.duration {
                let x = value.location.x
                let screen = UIScreen.main.bounds.width - 40
                let percent = x / screen
                let seconds = duration.seconds
                let currentSecond = Float64(Double(percent) * seconds)
                let getCurrentTime = CMTimeMakeWithSeconds(currentSecond, preferredTimescale: 1)
                audioManager.player.seek(to: getCurrentTime, toleranceBefore: .zero, toleranceAfter: .zero)
              }
            })//onEnded
          )//gesture
        }
        
        HStack {
          Text("\(audioManager.player.currentTime().seconds.asString(style: .positional) )")
          Spacer()
          Text("\(audioManager.player.currentItem!.asset.duration.seconds.asString(style: .positional) )")
        }
        .padding(.top, 8.0)
      }
      .padding(.bottom, 32.0)
      
      HStack(alignment: .center) {
        
        // MARK: Shuffle Button
        ZStack(alignment: .bottom) {
          PlaybackControlButton(systemName: "shuffle", color: audioManager.isShuffle ? Color("primary") : Color.white){
            audioManager.isShuffle.toggle()
          }
          if audioManager.isShuffle {
            Circle()
              .fill(Color("primary"))
              .frame(width: 4, height: 4)
          }
        }
        
        Spacer()
        
        // MARK: Backward Button
        PlaybackControlButton(systemName: "backward.end.fill") {
          previousSong()
        }
        
        Spacer()
        
        // MARK: Play/Pause Button
        PlayButton(systemName: audioManager.isPlaying ? "pause.fill" : "play.fill") {
          audioManager.playPause()
        }
        
        Spacer()
        
        // MARK: Forward Button
        VStack {
          PlaybackControlButton(systemName: "forward.end.fill") {
            nextSong()
          }
        }
        
        Spacer()
        
        // MARK: Looping Button
        ZStack(alignment: .bottom) {
          PlaybackControlButton(systemName: "repeat", color: audioManager.isLooping ? Color("primary") : Color.white) {
            audioManager.isLooping.toggle()
          }
          if audioManager.isLooping {
            Circle()
              .fill(Color("primary"))
              .frame(width: 4, height: 4)
          }
        }
      }
      
      // MARK: Timer Button
      Button(action: {
        showTimePicker = true
      }, label: {
        VStack(alignment: .center) {
          Image(systemName: "timer")
            .font(.system(size: 28, weight: .regular))
            .frame(width: 33, height: 33, alignment: .center)
            .foregroundColor( timerIsActive ? Color("primary") : .white)
          
          Circle()
            .fill(
              Color("primary").opacity(timerIsActive ? 1 : 0))
            .frame(width: 4, height: 4)
        }
      })
      .padding(.vertical, 24.0)
    }
    .padding(.bottom, 24.0)
  }
  
  func openPlayer() {
    audioManager.playSong(song: song)
    showLoading = true
    progressTime()
    indexes(song: song)
    nameOfPlaylist()
  }
  
  func newSong() {
    showLoading = true
    audioManager.player.seek(to: .zero)
    audioManager.player.pause()
    indexes(song: song)
    audioManager.playSong(song: song)
    nameOfPlaylist()
  }
  
  
  func nameOfPlaylist() {
    if favoritePlaylist {
      playlistName = "Favorites"
    } else {
      playlistName = songVM.playlists[playlistIndex].name
    }
  }

  // Desribing indexes for song in View Model
  func indexes(song: Song) {
    if favoritePlaylist {
      let indexS = favoriteVM.songs.firstIndex(where: {$0 == song})!
      songIndex = indexS
    } else {
      let indexP = songVM.playlists.firstIndex(where: {$0.songs.contains(song)})!
      playlistIndex = indexP
      let indexS = songVM.playlists[indexP].songs.firstIndex(where: {$0 == song})!
      songIndex = indexS
    }
  }
  
  // Desribing which song is next
  func nextSong() {
    if audioManager.isLooping {
      audioManager.playLoopSong()
    } else if favoritePlaylist {
      if audioManager.isShuffle {
        song = favoriteVM.songs.randomElement()!
      } else if songIndex == favoriteVM.songs.count-1 {
        song = favoriteVM.songs.first!
      } else {
        song = favoriteVM.songs[songIndex+1]
      }
    } else if audioManager.isShuffle {
      song = songVM.playlists[playlistIndex].songs.randomElement()!
    } else {
      songVM.nextSong(playlistIndex: playlistIndex, songIndex: songIndex) { song in
        self.song = song
      }
    }
  }
 
  // Desribing which song is previous
  func previousSong() {
    if audioManager.isLooping {
      audioManager.playLoopSong()
    } else if favoritePlaylist {
      if audioManager.isShuffle {
        song = favoriteVM.songs.randomElement()!
      } else if songIndex == 0 {
        song = favoriteVM.songs.last!
      } else {
        song = favoriteVM.songs[songIndex-1]
      }
    } else if audioManager.isShuffle {
      song = songVM.playlists[self.playlistIndex].songs.randomElement()!
    } else {
      songVM.previousSong(playlistIndex: playlistIndex, songIndex: songIndex) { song in
        self.song = song
      }
    }
  }
  
//Progeress Bar update every second
  func progressTime() {
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
      let screen = UIScreen.main.bounds.width - 40
      if let songDuration = audioManager.player.currentItem?.asset.duration.seconds {
        let currentTime = audioManager.player.currentTime().seconds
        let value = currentTime / songDuration
        width = screen * CGFloat(value)
        if currentTime > 0.01 {
          withAnimation(.easeOut) {
            showLoading = false
          }
        }
        if audioManager.finishedSong {
          nextSong()
          audioManager.finishedSong = false
        }
      }
    }
  }
}
