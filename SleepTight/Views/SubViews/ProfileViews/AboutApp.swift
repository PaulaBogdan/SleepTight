//
//  AboutApp.swift
//  SleepTight
//
//  Created by Paula on 26/09/2022.
//

import SwiftUI

struct AboutApp: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    ZStack(alignment: .top) {
      Color("background1")
        .edgesIgnoringSafeArea(.all)
      
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center) {
          VStack(alignment: .leading, spacing: 32.0){
            Text("Sleep Tight Baby")
              .font(.system(size: 34, weight: .bold))
              .foregroundColor(.white)
              .tracking(0.37)
            
            Text(sleepTightBabyDescription)
              .font(.system(size: 19, weight: .regular))
              .foregroundColor(Color.white)
              .tracking(-0.41)
              .lineSpacing(5)
          }
        }
      }
      .padding(.horizontal, 20.0)
    }
  }
  
  let sleepTightBabyDescription = """
◉ Music player application with carefully selected music for your baby.

◉ Choose from lullabies, classical music, calming music, sounds of nature, or various types of noises.

◉ Keep saving your most played tracks in your favorites list with an accessible tab.

◉ Use a timer to smoothly decreases the volume level to zero and save your phone’s battery life.

◉ You have easy access to recently played songs on home view so it’s fast to start listening to music.

◉ Use the power of the cloud - all data is stored in the cloud so doesn’t take up much memory on your phone and It’s possible to use the app on different devices with one account.
"""
}

struct AboutApp_Previews: PreviewProvider {
  static var previews: some View {
    AboutApp()
  }
}
