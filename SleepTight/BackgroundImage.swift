//
//  BackgroundImage.swift
//  SleepTight
//
//  Created by Paula on 04/01/2023.
//

import SwiftUI

struct BackgroundImage : View {
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color("background")
      Image("backgroundVector")
    }
    .edgesIgnoringSafeArea(.all)
  }
}
struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage()
    }
}
