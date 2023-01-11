//
//  RecentViewModel.swift
//  SleepTight
//
//  Created by Paula on 30/11/2022.
//


import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase

class RecentViewModel : ObservableObject, UserSongsProtocol {
  
  @Published public var songs: [Song] = []
  @Published public var songsId: [String] = []
  let songRepo: SongRepository
 
  
  init(songRepo: SongRepository) {
    self.songRepo = songRepo
    getUsersSongs()
  }
  
  
  func getUsersSongs() {
    if let user = Auth.auth().currentUser {
      let ref  = Firestore.firestore()
      ref.collection("users").document("\(user.uid)").getDocument { document, error in
        guard error == nil else {
          print(error!.localizedDescription)
          return
        }
        let data = document?.data()
        self.songsId = data?["recentSongs"] as? [String] ?? [""]
        self.songs = self.usersSongsFromId(songs: self.songRepo.songs)
      }
    }
  }
  
  func usersSongsFromId(songs: [Song]) -> [Song] {
    var songsArray:[Song] = []
    
    for id in self.songsId {
      if let index = songs.firstIndex(where: {$0.id == "\(id)"}) {
        songsArray.append(songs[index])
      }
    }
    return songsArray
  }
  
  func manageUsersSongs(songId: String) {
    if let user = Auth.auth().currentUser {
      addOrRemoveSong(songId: songId)
      let db = Firestore.firestore()
      let docRef = db.collection("users")
      docRef.document("\(user.uid)").setData(["recentSongs" : songsId], merge: true)
    }
  }
  
  func addOrRemoveSong(songId: String) {
    if let index = songsId.firstIndex(where: { $0 == songId }) {
      songsId.remove(at: index)
      songsId.append(songId)
      if (songsId.count) > 8  {
        songsId.remove(at: 0)
      }
    } else {
      songsId.append(songId)
      if (songsId.count) > 8  {
        songsId.remove(at: 0)
      }
    }
  }
}
