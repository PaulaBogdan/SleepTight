//
//  File.swift
//  SleepTight
//
//  Created by Paula on 14/04/2022.
//

import Firebase


public struct Playlist: Identifiable, Codable, Equatable {
  public var id: String = UUID().uuidString
  let name: String
  let songs: [Song]
}

public struct Song: Identifiable, Codable, Hashable{
  public var id: String = UUID().uuidString
  let image: String
  let title: String
  let author: String
  let track: String
}

final class SongViewModel : ObservableObject {
  
  @Published public var songs = [Song]()
  @Published public var playlists = [Playlist]()
  let songRepo: SongRepository
  
  
  init(songRepo: SongRepository) {
    self.songRepo = songRepo
    loadSongsData()
  }
  
  func loadSongsData() {
    songRepo.loadSongs() { songs in
      self.songs = songs
      self.songRepo.loadPlaylists(songs: songs) { playlists in
        self.playlists = playlists
      }
    }
  }
  
  func nextSong(playlistIndex: Int, songIndex: Int, completion: @escaping (Song) -> Void) {
    if songIndex == self.playlists[playlistIndex].songs.count-1 {
      completion(self.playlists[playlistIndex].songs[0])
    } else {
      completion(self.playlists[playlistIndex].songs[songIndex+1])
    }
  }
  
  
  func previousSong(playlistIndex: Int, songIndex: Int, completion: @escaping (Song) -> Void) {
    if songIndex == 0 {
      completion(self.playlists[playlistIndex].songs.last!)
    } else {
      completion(self.playlists[playlistIndex].songs[songIndex-1])
    }
  }
    
  }
  
  
