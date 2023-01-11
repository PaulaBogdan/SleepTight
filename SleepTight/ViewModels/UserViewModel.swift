//
//  UserViewModel.swift
//  SleepTight
//
//  Created by Paula on 25/07/2022.
//

import Foundation

class UserViewModel: ObservableObject {
  var name: String = ""
  var email: String = ""
  var password: String = ""
  
  func isEmpty(_ field:String) -> Bool {
    return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
  
  func isEmailValid(_ email: String) -> Bool {
    let emailTest = NSPredicate(format: "Self matches %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    return emailTest.evaluate(with: email)
  }
  
  func isPasswordValid(_ password: String) -> Bool {
    let passwodTest = NSPredicate(format: "Self matches %@", ".{8,}")
    return passwodTest.evaluate(with: password)
  }
  
  var isLogInComplete: Bool {
    !(isEmpty(email) || isEmpty(password))
  }
  
  var validNameText: String {
    if !isEmpty(name) {
      return ""
    } else {
      return "Don't be anonymous"
    }
  }
  
  var validEmailAdressText: String {
    if isEmailValid(email) {
      return ""
    } else {
      return "Invalid email. Check and try again"
    }
  }
  
  var validPasswordText: String {
    if isPasswordValid(password){
      return ""
    } else {
      return "Use at least 8 characters"
    }
  }
}
