//
//  SignInWithAppleObject.swift
//  SleepTight
//
//  Created by Paula on 18/07/2022.
//
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    @State private var currentNonce: String?
    var handleResult: ((Result<Bool,Error>) -> Void)? = nil
    
    var body: some View {
        SignInWithAppleButton(.continue,
                              onRequest: { request in
                                let nonce = FBAuth.randomNonceString()
                                currentNonce = nonce
                                request.requestedScopes = [.fullName, .email]
                                request.nonce = FBAuth.sha256(nonce)
                              },
                              onCompletion: { result in
                                switch result {
                                case .success(let authResult):
                                    switch authResult.credential {
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                        guard let nonce = currentNonce else {
                                            fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                        }
                                        guard let appleIDToken = appleIDCredential.identityToken else {
                                            print("Unable to fetch identity token")
                                            return
                                        }
                                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                            return
                                        }
                                        if let handleResult = handleResult {
                                            FBAuth.reauthenticateWithApple(idTokenString: idTokenString, nonce: nonce) { result in
                                                handleResult(result)
                                            }
                                        } else {
                                            FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { (result) in
                                                switch result {
                                                case .failure(let error):
                                                    print(error.localizedDescription)
                                                case .success(let authDataResult):
                                                    let signInWithAppleRestult = (authDataResult,appleIDCredential)
                                                    FBAuth.handle(signInWithAppleRestult) { (result) in
                                                        switch result {
                                                        case .failure(let error):
                                                            print(error.localizedDescription)
                                                        case .success:
                                                            print("Successful Login")
                                                        }
                                                    }
                                                }
                                            }//FBAuth.signInWithApple()
                                        }
                                    default:
                                        break
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                              }
        )
        .signInWithAppleButtonStyle(.white)
        .frame(width: UIScreen.main.bounds.width-40, height: 56)
        .cornerRadius(100)
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButtonView()
    }
}
