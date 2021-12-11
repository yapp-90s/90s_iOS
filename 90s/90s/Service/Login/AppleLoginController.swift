//
//  AppleLoginController.swift
//  90s
//
//  Created by woongs on 2021/12/04.
//

import Foundation
import RxSwift
import AuthenticationServices

protocol AppleLoginPresentable: UIViewController {

}

protocol AppleLoginControllerDelegate: AnyObject {
    func appleLoginController(_ controller: AppleLoginController, didLoginSucceedWith userInfo: AppleLoginController.CredentialUserInfo)
    func appleLoginController(_ controller: AppleLoginController, didLoginFailWith error: Error)
}

final class AppleLoginController: NSObject, ASAuthorizationControllerPresentationContextProviding {
    
    struct CredentialUserInfo {
        var identifier: String
        var email: String?
    }
    
    weak var viewController: AppleLoginPresentable?
    weak var delegate: AppleLoginControllerDelegate?
    var loginEmailPublishSubject = PublishSubject<String?>()
    
    func performExistingAccountSetupFlows() {
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: - ASAuthorizationControllerPresentationContextProviding
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let viewController = self.viewController else { return UIApplication.shared.windows.first! }
        return viewController.view.window!
    }
}

extension AppleLoginController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userInfo = CredentialUserInfo(identifier: appleIDCredential.user, email: appleIDCredential.email)
            self.saveUserInKeychain(userInfo)
            self.completeLogin(with: userInfo)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.appleLoginController(self, didLoginFailWith: error)
    }
    
    private func completeLogin(with userInfo: CredentialUserInfo) {
        if userInfo.email == nil {
            self.delegate?.appleLoginController(self, didLoginSucceedWith: .init(identifier: userInfo.identifier, email: UserManager.shared.appleEmail))
        } else {
            self.delegate?.appleLoginController(self, didLoginSucceedWith: userInfo)
        }
    }
    
    private func saveUserInKeychain(_ userInfo: CredentialUserInfo) {
        do {
            try KeychainItem(service: "com.team-90s", account: "userIdentifier").saveItem(userInfo.identifier)
            if let email = userInfo.email {
                try KeychainItem(service: "com.team-90s", account: "email").saveItem(email)
            }
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}
