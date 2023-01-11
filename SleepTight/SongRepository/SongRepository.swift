//
//  SongRepository.swift
//  SleepTight
//
//  Created by Paula on 16/12/2022.
//

import Firebase


class SongRepository: SongRepositoryProtocol {
  
  var songs: [Song] = []
  var playlists : [Playlist] = []
  
  init() {
    loadSongs() { songs in
      self.songs = songs
      self.loadPlaylists(songs: songs) { playlists in
        self.playlists = playlists
      }
    }
  }
  
  
  func loadSongs(completion: @escaping ([Song]) -> Void) {
    var songs:[Song] = []
    
    Firestore.firestore().collection("songs").getDocuments { (snapshot, error) in
      if error == nil {
        for document in snapshot!.documents {
          let songId = document.documentID
          let songTitle = document.data()["title"] as? String ?? "error"
          let songAuthor = document.data()["author"] as? String ?? "error"
          let songImage = document.data()["image"] as? String ?? "error"
          let songTrack = document.data()["track"] as? String ?? "error"
          let song = Song(id: songId, image: songImage, title: songTitle, author: songAuthor, track: songTrack)
          songs.append(song)
          songs.sort(by: {$0.id < $1.id })
        }
        completion(songs)
      } else {
        print(error as Any)
        completion([])
      }
    }
  }
  
  func loadPlaylists(songs: [Song], completion: @escaping ([Playlist]) -> Void)  {
    var playlists: [Playlist] = []
    
    Firestore.firestore().collection("allPlaylists").order(by: "number", descending: false).getDocuments { (snapshot, error) in
      if error == nil {
        for document in snapshot!.documents {
          let id = document.documentID
          let name = document.data()["name"] as? String ?? "error"
          let songsId = document.data()["songs"] as? [String] ?? []
          var songsObj: [Song] = []
          
          for songId in songsId {
            if let index = songs.firstIndex(where: {$0.id == "\(songId)"}  ) {
              songsObj.append(songs[index])
              songsObj.sort(by: {$0.id < $1.id })
            }
          }
          playlists.append(Playlist(id: id, name: name, songs: songsObj ))
        }
        completion(playlists)
      } else {
        print(error as Any)
      }
    }
  }
  
  
}
