//
//  TimerView.swift
//  SleepTight
//
//  Created by Paula on 12/07/2022.
//

import SwiftUI

struct TimerView: View {
  
  let timeOption: [Int] = [2*60,5*60,15*60,30*60,45*60,60*60,90*60,120*60]
  @Binding var selectedTime: Int
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.colorScheme) var colorScheme: ColorScheme
  @Binding var timerIsActive: Bool
  
  var body: some View {
    ZStack {
      VStack {
        Spacer()
        
        VStack(alignment: .center) {
          
          Spacer()
          
          VStack(spacing: 12.0) {
            Text("Set sleep timer")
              .font(.system(size: 22, weight: .bold))
              .tracking(0.35)
              .multilineTextAlignment(.center)
            
            Text("Once the timer ends, all sounds will be automatically paused.")
              .font(.system(size: 15, weight: .regular))
              .tracking(-0.24)
              .opacity(0.7)
              .multilineTextAlignment(.center)
          }
          if !timerIsActive {
            VStack {
              Picker("", selection: $selectedTime) {
                ForEach(timeOption, id: \.self) { time in
                  Text("\(time/60)" + " min")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.white)
                    .tracking(0.37)
                    .padding()
                }
              }
              .pickerStyle(.wheel)
              .labelsHidden()
            }
            
            
            timerButton
          }
          
          if timerIsActive {
              Button(action: {
                presentationMode.wrappedValue.dismiss()
                timerIsActive = false
              }) {
                ZStack {
                  RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(.white)
                    .frame(width: 155, height: 48, alignment: .center)
                  
                  Text("Clear timer")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.white)
                    .tracking(-0.24)
                }
              }
              .padding(.vertical, 30.0)
            
          }
          
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
              .padding(.vertical, 24.0)
              .font(.system(size: 28, weight: .regular))
          }
          
          HStack{Spacer()}
        }
        .frame(width: UIScreen.main.bounds.width, height: 504, alignment: .center)
        .padding(.horizontal, 20.0)
        .background(Color("background1"))
      }
    }
    .foregroundColor(Color.white)
    .background(Color.black.blendMode(.multiply))
    .edgesIgnoringSafeArea(.top)
  }
  
  
  
  var timerButton: some View {
    Button(action: {
      presentationMode.wrappedValue.dismiss()
      timerIsActive = true
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 100)
          .gradientButtonIcon(colors: [Color(#colorLiteral(red: 0.5803921818733215, green: 0.9372549057006836, blue: 0.9490196108818054, alpha: 1)), Color(#colorLiteral(red: 0.11104166507720947, green: 0.6328902244567871, blue: 0.6499999761581421, alpha: 1))])
          .frame(width: timerIsActive ? 155 : UIScreen.main.bounds.width-60, height: 48, alignment: .center)
        
        Text("Set sleep timer")
          .font(.system(size: 15, weight: .bold))
          .foregroundColor(Color.white)
          .tracking(-0.24)
      }
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView(selectedTime: .constant(300), timerIsActive: .constant(true))
      .environment(\.colorScheme, .dark)
  }
}
