//
//  SleepTightTests.swift
//  SleepTightTests
//
//  Created by Paula on 19/12/2022.
//

import XCTest
@testable import SleepTight

final class SleepTightTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
  }
  
  // testing returning value as a greeting text
  func test_GreetingTextShouldBeNotEqualToDefaultValue() {
    let greeting = Greeting()
    let text = greeting.greetingLogic()
    XCTAssertNotEqual(text, "Hello")
    XCTAssertTrue(!text.isEmpty)
  }
  
}
