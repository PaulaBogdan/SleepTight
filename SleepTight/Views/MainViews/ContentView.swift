//
//  ContentView.swift
//  SleepTight
//
//  Created by Paula on 09/04/2022.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject var userInfo: UserInfo
  
  var body: some View {
    Group {
      if userInfo.isUserAuthenticated == .undefined {
        Text("loading...")
      } else if userInfo.isUserAuthenticated == .signedOut {
        LoginView()
      } else if userInfo.isUserAuthenticated == .signedIn {
        MainView(songRepo: SongRepository())
      } else {
        EmptyView()
      }
    }
    .onAppear {
      self.userInfo.configureFirebaseStateDidChange()
    }
  }
}

