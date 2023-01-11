//
//  AudioManagerTests.swift
//  SleepTightTests
//
//  Created by Paula on 04/01/2023.
//

import XCTest
import Firebase
@testable import SleepTight

final class AudioManagerTests: XCTestCase {
  var sut: AudioManager!

    override func setUp() {
      super.setUp()
    }
    
    override func tearDown() {
      sut = nil
    }
    
    //time converter from sec into "00:00:00" format
    func test_audioManagerTimeConverter() {
      let sut = AudioManager()
      let sec = 180
      let text = sut.convertTime(timeInSeconds: sec)
      print(text)
      XCTAssertEqual(text, "00:03:00")
    }
  
    //converted time(double) into string
    func test_timeConverterAsString() {
      let time = 180.00
      let string = time.asString(style: .positional)
      XCTAssertEqual(string, "03:00")
    }
  
  func test_audioManager_playPause() {
    let sut = AudioManager()
    XCTAssertFalse(sut.isPlaying)
    sut.playPause()
    XCTAssertTrue(sut.isPlaying)
    XCTAssertNotNil(sut.player.play())
  }
  
  func test_audioManager_stopPlayer() {
    let sut = AudioManager()
    sut.stopPlaying()
    XCTAssertNil(sut.player.currentItem)

  }
  
}


