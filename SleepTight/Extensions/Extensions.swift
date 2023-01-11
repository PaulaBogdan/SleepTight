//
//  Extensions.swift
//  SleepTight
//
//  Created by Paula on 13/04/2022.
//

import Foundation
import SwiftUI


extension View {
    public func gradientButtonIcon(colors: [Color]) -> some View {
        self.overlay(LinearGradient(colors: [Color(#colorLiteral(red: 0.5803921818733215, green: 0.9372549057006836, blue: 0.9490196108818054, alpha: 1)), Color(#colorLiteral(red: 0.11104166507720947, green: 0.6328902244567871, blue: 0.6499999761581421, alpha: 1))], startPoint: UnitPoint(x: 0.5, y: -3.0616171314629196e-17),
                                    endPoint: UnitPoint(x: 0.5, y: 0.9999999999999999)))
            .mask(self)
    }
   
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func backgroundGradient(colors: [Color]) -> some View {
        self.overlay(LinearGradient(colors: [Color(UIColor(red: 0.055, green: 0.075, blue: 0.235, alpha: 1).cgColor), Color(UIColor(red: 0.281, green: 0.081, blue: 0.538, alpha: 1).cgColor)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

//MARK: - Converted time into string
extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    formatter.unitsStyle = style
    return formatter.string(from: self)!
  }
}

