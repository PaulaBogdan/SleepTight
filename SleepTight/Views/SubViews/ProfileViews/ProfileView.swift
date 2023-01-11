//
//  TimerView.swift
//  SleepTight
//
//  Created by Paula on 13/04/2022.
//

import SwiftUI
import MinimizableView

struct ProfileView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @EnvironmentObject var miniHandler: MinimizableViewHandler
  @EnvironmentObject var userInfo: UserInfo
  @ObservedObject var userVM = UserViewModel()
  @Binding var showSettings: Bool
  @State var showPrivacyPolicy: Bool = false
  @State var showTerms: Bool = false
  @State var showAccountDetails: Bool = false
  @State var showAuthenticationView: Bool = false
  @State var providers: [FBAuth.ProviderType] = []
  
  var body: some View {
    
    VStack(alignment: .leading) {
      NavigationView {
        VStack(alignment: .leading, spacing: 0.0) {
          HStack {
            Button(action: {
              withAnimation {
                showSettings = false
              }                        }, label: {
                Image(systemName: "control")
                  .font(.system(size: 28))
                  .rotationEffect(Angle(degrees: 270))
                  .frame(width: 33, height: 33, alignment: .center)
              })
            
            Spacer()
          }
          .padding(.vertical, 24.0)
          
          Text("Profile")
            .font(.system(size: 34, weight: .bold))
            .tracking(0.37)
          
          ProfileListView(userVM: userVM, showAuthenticationView: $showAuthenticationView,  providers: $providers, showSettings: $showSettings)
            .customListStyle()
        }
        .navigationTitle("Profile")
        .navigationBarHidden(true)
        .sheet(isPresented: $showPrivacyPolicy) {
          PrivacyPolicyView()
        }
        .sheet(isPresented: $showTerms) {
          TermsAndConditionsView()
        }
        .sheet(isPresented: $showAuthenticationView) {
          ReauthenticationView(userVM: userVM, providers: $providers)
        }
        .padding(.horizontal, 20.0)
        .background(
          Color("background1")
        )
      }
    }
  }
}


