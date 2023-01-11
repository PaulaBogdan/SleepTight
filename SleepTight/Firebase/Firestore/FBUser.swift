//
//  FBUser.swift
//  Signin With Apple


import Foundation

struct FBUser {
  let uid: String
  let name: String
  let email: String
  let favoritesSongs: [String]
  let recentSongs: [String]
  
  init(uid: String,
       name: String,
       email: String,
       favoritesSongs: [String],
       recentSongs: [String]
  ) {
    self.uid = uid
    self.name = name
    self.email = email
    self.favoritesSongs = favoritesSongs
    self.recentSongs = recentSongs
  }
}

extension FBUser {
  init?(documentData: [String : Any]) {
    let uid = documentData[FBKeys.User.uid] as? String ?? ""
    let name = documentData[FBKeys.User.name] as? String ?? ""
    let email = documentData[FBKeys.User.email] as? String ?? ""
    let favoritesSongs = documentData[FBKeys.User.favoritesSongs] as? [String] ?? [""]
    let recentSongs = documentData[FBKeys.User.recentSongs] as? [String] ?? [""]
    
    self.init(uid: uid,
              name: name,
              email: email,
              favoritesSongs: favoritesSongs,
              recentSongs: recentSongs)
  }
  
  static func dataDict(uid: String, name: String, email: String, favoritesSongs: [String], recentSongs: [String]) -> [String: Any] {
    var data: [String: Any]
    
    if name != "" {
      data = [
        FBKeys.User.uid: uid,
        FBKeys.User.name: name,
        FBKeys.User.email: email,
        FBKeys.User.favoritesSongs: favoritesSongs,
        FBKeys.User.recentSongs: recentSongs]
    } else {
      data = [
        FBKeys.User.uid: uid,
        FBKeys.User.email: email]
    }
    return data
  }
}
