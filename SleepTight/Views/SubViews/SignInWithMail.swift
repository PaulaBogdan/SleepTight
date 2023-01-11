//
//  SignInWithMail.swift
//  SleepTight
//
//  Created by Paula on 18/07/2022.
//

import SwiftUI

struct SignUpWithMail: View {
//    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
 

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 71, height: 36, alignment: .center)
                            .foregroundColor(Color.white.opacity(0.2))

                        Text("Login")
                            .font(.system(size: 15, weight: .semibold))
                            .tracking(-0.5)
                    }
                })

                Spacer()

                Button(action: {
//                    presentationMode.wrappedValue.dismiss()

                }, label:
                        {
                    Image(systemName: "xmark")
                        .font(.system(size: 28, weight: .regular))
                })

            }
            .padding([.top, .leading, .trailing], 16.0)

            Text("Create an account")
                .font(.system(size: 34, weight: .bold))
                .tracking(0.37)
            
            
            VStack(spacing: 16.0) {
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding(.leading, 16.0)


                    TextField("Name", text: $name)
                        .textContentType(.givenName)
                        .autocapitalization(.none)
                }
                .frame(height: 56)
                .background(Color("background2"))
                .cornerRadius(6)

                HStack(spacing: 8.0) {
                    Image(systemName: "envelope")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))                        .frame(width: 24, height: 24, alignment: .center)
                        .padding(.leading, 16.0)


                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                }
                .frame(height: 56)
                .background(Color("background2"))
                .cornerRadius(6)


                HStack(spacing: 8.0) {
                    Image(systemName: "lock")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))                        .frame(width: 24, height: 24, alignment: .center)
                        .padding(.leading, 16.0)


                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .autocapitalization(.none)
                }
                .frame(height: 56)
                .background(Color("background2"))
                .cornerRadius(6)
            }
            .padding(.horizontal, 24.0)
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.white)
                .frame(width: .infinity, height: 56, alignment: .center)
                
                Text("Sign Up")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(#colorLiteral(red: 0.02, green: 0.03, blue: 0.16, alpha: 1)))
                    .tracking(-0.41)
            }
            .padding(.all, 24.0)
           
            Text("By continuing I agree with the Terms & Conditions and Privacy Policy")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .background(Color("background1"))
    }
}

struct SignUpWithMail_Previews: PreviewProvider {
    static var previews: some View {
        SignUpWithMail()
            .preferredColorScheme(.dark)
    }
}
