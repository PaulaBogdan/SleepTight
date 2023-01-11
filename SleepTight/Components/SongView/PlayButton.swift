//
//  PlayButton.swift
//  SleepTight
//
//  Created by Paula on 13/04/2022.
//

import SwiftUI

struct PlayButton: View {
  
  let systemName: String
  let actionPlay: () -> Void
  
  var body: some View {
    Button(action: actionPlay) {
      ZStack {
        Circle()
          .frame(width: 80, height: 80, alignment: .center)
          .gradientButtonIcon(colors: [Color(#colorLiteral(red: 0.5803921818733215, green: 0.9372549057006836, blue: 0.9490196108818054, alpha: 1)), Color(#colorLiteral(red: 0.11104166507720947, green: 0.6328902244567871, blue: 0.6499999761581421, alpha: 1))])
        
        Image(systemName: systemName)
          .foregroundColor(.white)
          .font(.system(size: 32))
      }
    }
  }
}

struct PlayButton_Previews: PreviewProvider {
  static var previews: some View {
    PlayButton(systemName:"play.fill", actionPlay: {} )
  }
}
