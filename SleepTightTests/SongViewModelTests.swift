//
//  SongViewModelTests.swift
//  SleepTightTests
//
//  Created by Paula on 02/01/2023.
//

import XCTest
@testable import SleepTight

final class SongViewModelTests: XCTestCase {
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_SongViewModel_songsArray_shouldBeEmpty() {
    let songVM = SongViewModel(songRepo: SongRepository())
    XCTAssertTrue(songVM.songs.isEmpty)
  }
  
  func test_SongViewModel_playlistArray_shouldBeEmpty() {
    let songVM = SongViewModel(songRepo: SongRepository())
    XCTAssertTrue(songVM.playlists.isEmpty)
  }
  
  
}
