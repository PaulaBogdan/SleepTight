//
//  TermsAndConditions.swift
//  SleepTight
//
//  Created by Paula on 08/08/2022.
//

import SwiftUI

struct TermsAndConditionsView: View {
  @Environment(\.presentationMode) var presentationMode
  var isSheet: Bool = false
  
  var body: some View {
    ZStack {
      Color("background1")
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        if isSheet {
          HStack {
            HStack {
              Image(systemName: "chevron.left" )
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.white)
                .onTapGesture {
                  self.presentationMode.wrappedValue.dismiss()
                }
              
              Text("Back")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.white)
            }
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
          }
          .padding(.vertical, 24.0)
        }
        
        ScrollView {
          VStack {
            VStack(alignment: .leading, spacing: 32.0){
              Text("Terms & Conditions")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .tracking(0.35)
              
              Text(termsAndConditionsDescription)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .tracking(-0.41)
              
              Text("Who May Use the Services")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .tracking(0.35)
              
              Text(whoMayUseServicesDescription)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .tracking(-0.41)
              
              
              Text("Changes to This Terms and Conditions")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .tracking(0.35)
              
              Text(changesTermsAndConditionDescription)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .tracking(-0.41)
              
              Text("Contact Us")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .tracking(0.35)
              
              Text(contactUsDescription)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .tracking(-0.41)
            }
          }
          .background(Color("background1"))
        }
      }
      .padding(.horizontal, 16.0)
    }
  }
  
  let termsAndConditionsDescription = """
  By downloading or using the Sleep Tight Baby, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Paula Bogdan.\n\nPaula Bogdan is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n\nThe Sleep Tight app stores and processes personal data that you have provided to us, in order to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We, therefore, recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Sleep Tight app won’t work properly or at all.\n\nThe app does use third-party services but doesn't collect any personal data.\nYou should be aware that there are certain things that Paula Bogdan will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Paula Bogdan cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\n\nIf you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n \nAlong the same lines, Paula Bogdan cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail of the Service, Paula Bogdan cannot accept responsibility.\n\nWith respect to Paula Bogdan’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Paula Bogdan accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n\nAt some point, we may wish to update the app. The app is currently available on iOS – the requirements for the system (and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Paula Bogdan does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.
  """
  
let whoMayUseServicesDescription = """
Registration may be required for the use of certain Services and portions of the Website. If you choose to provide information to the Website, you agree to provide only true, current and complete information. If you create a user account, you agree to accept responsibility for all activities that occur under your account or password, if any, and agree you will not sell, transfer or assign your user account. You are responsible for maintaining the confidentiality of your password.\n\nYou may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you without appropriate authorization, or a name that is otherwise offensive, vulgar or obscene. You are responsible for maintaining the confidentiality of your password and are solely responsible for all activities resulting from the use of your password and conducted through your Sleep Tight Baby account.
"""
  
let changesTermsAndConditionDescription = """
We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page. These changes are effective immediately after they are posted on this page.
"""
  
let contactUsDescription = """
If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at paulabogdan2205@gmail.com
"""
}

struct TermsAndConditionsView_Previews: PreviewProvider {
  static var previews: some View {
    TermsAndConditionsView(isSheet: true)
  }
}
