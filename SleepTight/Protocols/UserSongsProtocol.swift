//
//  UserSongsProtocol.swift
//  SleepTight
//
//  Created by Paula on 03/01/2023.
//

import Foundation

protocol UserSongsProtocol {
  func getUsersSongs()
  func usersSongsFromId(songs: [Song]) -> [Song]
  func manageUsersSongs(songId: String)
  func addOrRemoveSong(songId: String) 
}
