//
//  FavoritesViewModelTests.swift
//  SleepTightTests
//
//  Created by Paula on 02/01/2023.
//

import XCTest
@testable import SleepTight

final class FavoritesViewModelTests: XCTestCase {

  var sut: FavoritesViewModel!
  var songsArray: [Song]!
  
  override func setUp() {
    super.setUp()
    songsArray = [Song(id: "0", image: "", title: "", author: "", track: ""),
                  Song(id: "1", image: "", title: "", author: "", track: ""),
                  Song(id: "2", image: "", title: "", author: "", track: ""),
                  Song(id: "3", image: "", title: "", author: "", track: ""),
                  Song(id: "4", image: "", title: "", author: "", track: ""),
                  Song(id: "5", image: "", title: "", author: "", track: ""),
                  Song(id: "6", image: "", title: "", author: "", track: ""),
                  Song(id: "7", image: "", title: "", author: "", track: "")
                  ]
  }
  
  override func tearDown()  {
    super.tearDown()
    sut = nil
  }
  
  func test_recentViewModel_songsArray_shouldBeEmpty() {
    let sut = FavoritesViewModel()
    XCTAssertTrue(sut.songs.isEmpty)
  }
  
  func test_recentViewModel_songsIdArray_shouldBeEmpty() {
    let sut = FavoritesViewModel()
    XCTAssertTrue(sut.songsId.isEmpty)
  }
  
  func test_usersSongsFromId_shouldHaveTwoSongsLikeMockArray() {
    let sut = FavoritesViewModel()
    let songsId = [songsArray[0].id, songsArray[1].id]
    sut.songsId = songsId
    let songsTest = sut.usersSongsFromId(songs: songsArray)
    print(songsTest)
    XCTAssertEqual(songsTest, [songsArray[0], songsArray[1]])
    XCTAssertFalse(songsTest.isEmpty)
    XCTAssertEqual(songsTest.count, 2)
  }
  
  
  func test_usersSongsFromId_shouldHaveOneSongsFromMockArray() {
    let sut = FavoritesViewModel()
    let songsId = [songsArray[0].id]
    sut.songsId = songsId
    let songsTest = sut.usersSongsFromId(songs: songsArray)
    print(songsTest)
    XCTAssertEqual(songsTest[0], songsArray[0])
    XCTAssertTrue(songsTest == [songsArray[0]])
    XCTAssertFalse(songsTest.isEmpty)
    XCTAssertEqual(songsTest.count, 1)
  }
  
  func test_addOrRemoveSong_shouldAddOne() {
    let sut = FavoritesViewModel()
    let songId = songsArray[0].id
    sut.addOrRemoveSong(songId: songId)
    print(sut.songsId)
    XCTAssertFalse(sut.songsId.isEmpty)
    XCTAssertEqual(sut.songsId.count, 1)
    XCTAssertEqual(sut.songsId, [songId])
  }
  
  func test_addOrRemoveSong_shouldRemoveFirstAndHasOneLessItems() {
    let sut = FavoritesViewModel()
    sut.songsId = [songsArray[0].id, songsArray[1].id,songsArray[2].id, songsArray[3].id]
    let songId = songsArray[0].id
    sut.addOrRemoveSong(songId: songId)
    XCTAssertFalse(sut.songsId.isEmpty)
    XCTAssertNotEqual(sut.songsId.first, songId)
    XCTAssertEqual(sut.songsId.count, 3)
    XCTAssertFalse(sut.songsId.contains(songId))
  }
  
  func test_addOrRemoveSong_shouldAddNewItem() {
    let sut = FavoritesViewModel()
    sut.songsId = [songsArray[0].id, songsArray[1].id,songsArray[2].id, songsArray[3].id]
    let songId = songsArray[4].id
    sut.addOrRemoveSong(songId: songId)
    XCTAssertFalse(sut.songsId.isEmpty)
    XCTAssertEqual(sut.songsId.count, 5)
    XCTAssertEqual(sut.songsId.last, songId)
  }
  
}
