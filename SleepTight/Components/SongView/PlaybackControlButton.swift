//
//  PlaybackControlButton.swift
//  paula1234
//
//  Created by Paula on 16/03/2022.
//

import SwiftUI

struct PlaybackControlButton: View {
  
  let systemName: String
  let fontSize: CGFloat = 28
  var color: Color = Color.white
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      VStack(alignment: .center, spacing: 0) {
        Image(systemName: systemName)
          .font(.system(size: fontSize))
          .foregroundColor(color)
      }
      .frame(height: 45)
    }
  }
}
