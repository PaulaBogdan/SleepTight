//
//  UserInfo.swift
//  Firebase Login

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
  enum FBAuthState {
    case undefined, signedOut, signedIn
  }
  @Published var isUserAuthenticated: FBAuthState = .undefined
  @Published var user: FBUser = .init(uid: "",
                                      name: "",
                                      email: "",
                                      favoritesSongs: [],
                                      recentSongs: [])
  
  var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
  
  func configureFirebaseStateDidChange() {
    authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
      guard let user = user else {
        self.isUserAuthenticated = .signedOut
        return
      }
      self.isUserAuthenticated = .signedIn
      FBFirestore.retrieveFBUser(uid: user.uid) { (result) in
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
        case .success(let user):
          self.user = user
        }
      }
    })
  }//func configureFirebaseStateDidChange()
}//class UserInfo
