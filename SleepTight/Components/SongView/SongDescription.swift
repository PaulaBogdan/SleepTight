//
//  SongDescription.swift
//  SleepTight
//
//  Created by Paula on 08/11/2022.
//

import SwiftUI

struct SongDescription: View {
  var alignmentStack:HorizontalAlignment = .leading
  var alignmentText: TextAlignment = .leading
  var spacing: Double = 2.0
  var title: String
  var author: String
  var fontTitle: Font = .footnote
  var fontAuthor: Font = .footnote
  var tracking: Double = (-0.08)
  var fontWeight: Font.Weight = .semibold
  var opacity: Double = 0.7
  
  var body: some View {
    VStack(alignment: alignmentStack, spacing: spacing) {
      Text(title)
        .font(fontTitle)
        .tracking(tracking)
        .fontWeight(fontWeight)
        .multilineTextAlignment(alignmentText)
        .lineLimit(1)
      
      Text(author)
        .font(fontAuthor)
        .tracking(tracking)
        .opacity(opacity)
        .lineLimit(1)
    }
  }
}

struct SongDescription_Previews: PreviewProvider {
  static var previews: some View {
    SongDescription(title: "title", author: "author")
  }
}
