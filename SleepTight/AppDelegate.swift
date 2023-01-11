//
//  AppDelegate.swift
//  SleepTight
//
//  Created by Paula on 14/04/2022.
//

import UIKit
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    if #available(iOS 15.0, *) {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(red: 0.02111111581325531, green: 0.032789602875709534, blue: 0.15833333134651184, alpha: 0.699999988079071)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
      }
    return true
  }
  
  func application(_ application: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey: Any])
  -> Bool {
    GIDSignIn.sharedInstance.handle(url)
  }
}
