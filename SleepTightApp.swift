//
//  SleepTightApp.swift
//  SleepTight
//
//  Created by Paula on 09/04/2022.
//

import SwiftUI
import Firebase
import MinimizableView

@main
struct SleepTightApp: App {
  
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject private var userInfo = UserInfo()
    @StateObject var miniHandler = MinimizableViewHandler()

    init() {
        FirebaseApp.configure()
        Firestore.firestore()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .dark)
                .environmentObject(self.userInfo)
                .environmentObject(self.miniHandler)
        }
    }
}

