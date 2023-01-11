//
//  SongRepositoryProtocol.swift
//  SleepTight
//
//  Created by Paula on 16/12/2022.
//

import Foundation

protocol SongRepositoryProtocol {

  func loadSongs(completion: @escaping ([Song]) -> Void) 
  func loadPlaylists(songs: [Song], completion: @escaping ([Playlist]) -> Void) 
}
