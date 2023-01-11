//
//  LoadingScreen.swift
//  SleepTight
//
//  Created by Paula on 08/11/2022.
//

import SwiftUI

struct LoadingScreen: View {
  var body: some View {
    ZStack {
      Color.black.opacity(0.3)
      
      ProgressView()
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct LoadingScreen_Previews: PreviewProvider {
  static var previews: some View {
    LoadingScreen()
  }
}
