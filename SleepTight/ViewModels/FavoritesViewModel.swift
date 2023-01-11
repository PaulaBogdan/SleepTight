//
//  FavoritesViewModel.swift
//  SleepTight
//
//  Created by Paula on 30/11/2022.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


class FavoritesViewModel : ObservableObject, UserSongsProtocol {

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
        let favSongsId : [String] = data?["favoritesSongs"] as? [String] ?? [""]
        self.songsId = favSongsId
        self.songs = self.usersSongsFromId(songs: self.songRepo.songs)
      }
    }
  }
  
  func usersSongsFromId(songs: [Song]) -> [Song] {
    var favSongs:[Song] = []
    
    for id in self.songsId {
      if let index = songs.firstIndex(where: {$0.id == "\(id)"}) {
        favSongs.append(songs[index])
      }
    }
    return favSongs
  }
  
  func manageUsersSongs(songId: String) {
    if let user = Auth.auth().currentUser {
      addOrRemoveSong(songId: songId)
      let db = Firestore.firestore()
      let docRef = db.collection("users")
      docRef.document("\(user.uid)").setData(["favoritesSongs" : songsId], merge: true)
    }
  }
 
  func addOrRemoveSong(songId: String) {
    if let index = songsId.firstIndex(of: songId) {
      songsId.remove(at: index)
    } else {
      songsId.append(songId)
    }
  }
  
}


