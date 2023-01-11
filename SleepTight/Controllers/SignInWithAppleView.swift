
import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: UIViewRepresentable {
    
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  //Create an Apple Button view with authorization
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    let button = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .white)
    button.addTarget(context.coordinator,
                     action: #selector(Coordinator.handleAuthorizationAppleIDButtonPress),
                     for: .touchUpInside)
    return button
  }
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
  
  class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    let parent: SignInWithAppleView
    var currentNonce: String?
    
    init(_ parent: SignInWithAppleView) {
      self.parent = parent
      super.init()
    }
    
    //MARK: -AuthorizationAppleButtonPress
    @objc func handleAuthorizationAppleIDButtonPress() {
      let provider = ASAuthorizationAppleIDProvider()
      currentNonce = FBAuth.randomNonceString()
      let request = provider.createRequest()
      request.requestedScopes = [.fullName, .email]
      let authController = ASAuthorizationController(authorizationRequests: [request])
      authController.presentationContextProvider = self
      authController.delegate = self
      authController.performRequests()
    }
  
    // MARK: - ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
      let vc = UIApplication.shared.windows.last?.rootViewController
      return (vc?.view.window!)!
      //ASPresentationAnchor()
    }
    
    // MARK: - ASAuthorizationControllerDelegate
    internal func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        guard let nonce = currentNonce else {
          fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
          print("Unable to fetch identity token")
          return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
          print("Unable to serialize token string from data")
          return
        }
        
        FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { (result) in
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success(let authDataResult):
            let signInWithAppleResult = (authDataResult, appleIDCredential)
            FBAuth.handle(signInWithAppleResult) { (result) in
              switch result {
              case .failure(let error):
                print(error.localizedDescription)
              case .success:
                print("Succesful Login")
              }
            }
          }
        }//FBAuth.signInWithApple()
      } else {
        print("Could not get credentials")
      }
    }
  }
}
