//
//  PrivacyPolicyView.swift
//  SleepTight
//
//  Created by Paula on 08/08/2022.
//

import SwiftUI

struct PrivacyPolicyView: View {
  @Environment(\.presentationMode) var presentationMode
  var isSheet: Bool = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Color("background1")
          .edgesIgnoringSafeArea(.bottom)
        
        VStack {
          if isSheet {
            HStack {
              HStack {
                Image(systemName: "chevron.left" )
                  .font(.system(size: 28, weight: .regular))
                  .foregroundColor(.white)
                
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
            VStack(alignment: .leading, spacing: 24.0) {
              VStack(alignment: .leading, spacing: 32.0){
                Text("Privacy Policy")
                  .font(.system(size: 34, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.37)
                
                Text(mainDescription)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Information Collection and Use")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                
                Text("The app does not collect any data related to your identity.")
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Log Data")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
               Text(logDataText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Cookies")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(cookiesText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Service Providers")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(serviceProvidersText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0) {
                Text("Security")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(securityText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Links to Other Sites")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(linksToOtherSitesText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0) {
                Text("Intellectual Property Rights")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(intellectualPropertyRightsText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Changes to This Privacy Policy")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text(changesToPrivacyPolicyText)
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
                +
                
                Text("2022-10-19")
                  .font(.system(size: 17, weight: .bold))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
              
              VStack(alignment: .leading, spacing: 16.0){
                Text("Contact Us")
                  .font(.system(size: 22, weight: .bold))
                  .foregroundColor(.white)
                  .tracking(0.35)
                
                Text("If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at paulabogdan2205@gmail.com")
                  .font(.system(size: 17, weight: .regular))
                  .foregroundColor(.white.opacity(0.7))
                  .tracking(-0.41)
              }
            }
          }
        }
        .padding(.horizontal, 16.0)
        .background(Color("background1"))
      }
      .navigationBarHidden(true)
    }
  }
  
let mainDescription = """
Paula Bogdan built Sleep Tight Baby as a free app. This service is provided by Paula Bogdan at no cost and is intended for use as is. This page is used to inform visitors regarding my policies regarding the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\n\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at SleepTight unless otherwise defined in this Privacy Policy.
"""
  
let logDataText = """
Information Related to Use of the Services: Our servers automatically record certain information about how a person uses our Services (we refer to this information as “Log Data”), including both Account holders and non-Account holders (either, a “User”). Log Data may include information such as a User’s Internet Protocol (IP) address, browser type, operating system, the web page that a User was visiting before accessing our Services, the pages or features of our Services to which a User browsed and the time spent on those pages or features, search terms, the links on our Services that a User clicked on and other statistics. We use this information to administer the Services and we analyze (and may engage third parties to analyze) this information to improve and enhance the Services by expanding their features and functionality and tailoring them to our Users’ needs and preferences. We may use a person’s IP address to fight spam, malware, and identity theft. We also use the IP Address to generate aggregate, non-identifying information about how our Services are used. We use Google Analytics to collect, monitor, and analyze Log Data in order to increase our Services’ functionality and user-friendliness, and to better tailor our Services to our visitors’ needs. We also use this information to verify that visitors to the Services meet the criteria required to process their requests. Accordingly, Log Data is shared with Google which has its own privacy policies (accessible at http://www.google.com/policies/privacy/respectively) addressing how these parties use such information.
"""
  
let cookiesText = """
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.
"""

let serviceProvidersText = """
I may employ third-party companies and individuals due to the following reasons:\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nI want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.
"""

let securityText = """
I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.
"""
let linksToOtherSitesText = """
This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.
"""
  
let intellectualPropertyRightsText = """
The SleepTight application and all related software, trademarks, logos, images and other intellectual property rights are and shall remain our exclusive property. Your right to use the Application and its content is personal, non-exclusive, non-sublicenseable and non-transferable. Any copying, republication or redistribution of the SleepTight application and contained content is strictly prohibited.
"""

let changesToPrivacyPolicyText = """
SleepTight may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.\nThis policy is effective as of
"""
  
}
struct PrivacyPolicyView_Previews: PreviewProvider {
  static var previews: some View {
    PrivacyPolicyView(isSheet: true)
  }
}
