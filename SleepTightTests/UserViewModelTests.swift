//
//  UserViewModelTests.swift
//  SleepTightTests
//
//  Created by Paula on 02/01/2023.
//

import XCTest
@testable import SleepTight

final class UserViewModelTests: XCTestCase {
  
  var sut: UserViewModel!
  
  override func setUp() {
    super.setUp()
    sut = UserViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_isStringEmpty() throws {
    let name:String = ""
    XCTAssertTrue(sut.isEmpty(name))
  }
  
  func test_isEmailValidShouldBeTrue() throws {
    let email = "paula@p.pl"
    XCTAssertTrue(sut.isEmailValid(email))
  }
  
  func test_isEmailValidShouldBeFalse() throws {
    let email = "paula@.pl"
    XCTAssertFalse(sut.isEmailValid(email))
  }
  
  func test_isPasswordValidShouldBeTrue() throws {
    let password = "gdgdgd..."
    XCTAssertTrue(sut.isPasswordValid(password))
  }
  
  func test_isPasswordValidShouldBefalse() throws {
    let password = ".."
    XCTAssertFalse(sut.isPasswordValid(password))
  }
}
