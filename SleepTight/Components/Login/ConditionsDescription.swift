//
//  ConditionsDescription.swift
//  SleepTight
//
//  Created by Paula on 17/11/2022.
//

import SwiftUI

struct ConditionsDescription: View {
  
  var body: some View {
    VStack {
      Text("By continuing I agree with")
      
      HStack(spacing: 2.0) {
        Text("the")
        
        NavigationLink(destination: TermsAndConditionsView(isSheet: true).navigationBarHidden(true), label: {
          Text("Terms & Conditions")
            .underline()
        })
        
        Text("and")
        
        NavigationLink(destination: PrivacyPolicyView(isSheet: true).navigationBarHidden(true), label: {
          Text("Privacy Policy")
            .underline()
        })
      }//HStack
    }//VStack
    .font(.system(size: 12, weight: .regular))
    .foregroundColor(Color.white.opacity(0.7))    }
}

struct ConditionsDescription_Previews: PreviewProvider {
  static var previews: some View {
    ConditionsDescription()
  }
}
