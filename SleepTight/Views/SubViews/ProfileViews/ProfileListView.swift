//
//  ProfileListView.swift
//  SleepTight
//
//  Created by Paula on 08/11/2022.
//

import SwiftUI
import MinimizableView


struct ProfileListView: View {
  @EnvironmentObject var userInfo: UserInfo
  @EnvironmentObject var audioManager: AudioManager
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @ObservedObject var userVM: UserViewModel
  @Binding var showAuthenticationView : Bool
  @Binding var providers: [FBAuth.ProviderType]
  @Binding var showSettings: Bool
  @State var showPrivacyPolicy: Bool = false
  @State var showTerms: Bool = false
  @State var showAccountDetails: Bool = false
  
  var body: some View {
    List {
      Section {
        NavigationLink(destination: {
          ChangePassword(showSettings: $showSettings)
        }, label:  {
          SettingsRowView(imageName: "lock", text: "Change password")
        })
      }.listRowBackground(Color("background2"))
      
      Section {
        Link(destination: URL(string: "https://apps.apple.com/pl/app/sleep-tight-baby/id6443919105?l=pl")!, label: {
          SettingsRowView(imageName: "star", text: "Rate App")
        })
        if #available(iOS 16.0, *) {
          ShareLink(item: URL(string: "https://apps.apple.com/pl/app/sleep-tight-baby/id6443919105?l=pl")!, label: {
            SettingsRowView(imageName: "square.and.arrow.up", text: "Share the App")
          })
        } else {
          SettingsRowView(imageName: "square.and.arrow.up", text: "Share the App")
            .onTapGesture {
              shareApp()
            }
        }
      }
      .listRowBackground(Color("background2"))
      
      Section {
        NavigationLink(destination: {
          TermsAndConditionsView(isSheet: true).navigationBarHidden(true)
        }, label:  {
          SettingsRowView(imageName: "checkmark.shield", text: "Terms and conditions")
        })
        NavigationLink(destination: {
          PrivacyPolicyView(isSheet: true).navigationBarHidden(true)
        }, label:  {
          SettingsRowView(imageName: "doc.text", text: "Privacy Policy")
        })
      }
      .listRowBackground(Color("background2"))
      
      Section {
        NavigationLink(destination: {
          AboutApp()
        }, label:  {
          SettingsRowView(imageName: "info.circle", text: "About app")
        })
      }.listRowBackground(Color("background2"))
      
      Section {
        Button(action: {
          self.logout()
        }, label: {
          SettingsRowView(imageName: "rectangle.portrait.and.arrow.right", text: "Logout")
        })
      }
      .listRowBackground(Color("background2"))
      
      Section {
        Button(action: {
          showAuthenticationView = true
          audioManager.stopPlaying()
        }, label: {
          SettingsRowView(imageName: "trash", text: "Delete account", color: Color("errorText"))
        })
      }
      .listRowBackground(Color("background2"))
    }
    .listStyle(.grouped)
    .listRowSeparator(.hidden)
  }
  
  func shareApp() {
    let url = URL(string: "https://apps.apple.com/pl/app/sleep-tight-baby/id6443919105?l=pl")
    let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    audioManager.player.pause()
  }
  
  func logout() {
    FBAuth.logout { (result) in
      audioManager.stopPlaying()
      miniHandler.isPresented = false
      getRootViewController()
    }
  }
}

//MARK: - Set the same background in different iOS version
@available(iOS 16, *)
struct ProfileNewListModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .scrollContentBackground(.hidden)
      .background(Color("background1"))
  }
}

struct ProfileListModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        UITableView.appearance().backgroundColor = .clear
      }
  }
}

extension View {
  @ViewBuilder
  func customListStyle() -> some View {
    if #available(iOS 16, *) {
      AnyView( self.modifier(ProfileNewListModifier()))
    }
    else {
      self.modifier(ProfileListModifier())
    }
  }
}
