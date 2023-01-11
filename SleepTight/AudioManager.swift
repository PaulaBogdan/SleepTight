//
//  AudioManager.swift
//  MeditationApp
//
//  Created by Paula on 16/03/2022.
//


import Foundation
import AVFoundation
import AVKit
import Firebase

final class AudioManager: ObservableObject {
  
  var player = AVPlayer()
  var finishedSong: Bool = false
  var isPlaying: Bool = false
  var isLooping: Bool = false
  var isShuffle: Bool = false
  
  func playSong(song: Song) {
    let storage = Storage.storage().reference(forURL: song.track)
    storage.downloadURL { (url,error) in
      if error != nil {
        print(error as Any)
      } else {
        let audioSession = AVAudioSession.sharedInstance()
        do {
          try audioSession.setCategory(.playback, mode: .default)
          let item = AVPlayerItem(url: url!)
          self.player.replaceCurrentItem(with: item)
          self.player.play()
          self.isPlaying = true
          NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
        } catch {
          print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
      }
    }
  }
  
  @objc func playerDidFinishPlaying(sender: Notification) {
      self.finishedSong = true
      NotificationCenter.default.removeObserver(self)
    }
  
  func fadeVolume(to: Float, duration: Float, completion: (() -> Void)? = nil) -> Timer? {
    let volume = self.player.volume
    let from = volume
    guard from != to else { return nil }
    let interval: Float = 0.1
    let range: Float = -1
    let step = (range*interval)/duration
   
    return Timer.scheduledTimer(withTimeInterval: Double(interval), repeats: true, block: { [weak self] (timer) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if self.player.volume <= 0 {
          timer.invalidate()
          self.player.pause()
          self.isPlaying = false
          self.player.volume = 1
          completion?()
        } else {
          self.player.volume += step
          print(self.player.volume)
        }
      }
    })
  }
  
  func playPause() {
    if isPlaying {
      player.pause()
    } else {
      player.play()
    }
    isPlaying.toggle()
  }
  
  func playLoopSong() {
    self.player.seek(to: .zero)
    self.player.play()
  }
  
  func convertTime(timeInSeconds: Int) -> String {
    let hours = timeInSeconds / 3600
    let minutes = timeInSeconds / 60 % 60
    let seconds = timeInSeconds % 60
    return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
  }
  
  func stopPlaying() {
    self.player.pause()
    self.player.replaceCurrentItem(with: nil)
  }
}







