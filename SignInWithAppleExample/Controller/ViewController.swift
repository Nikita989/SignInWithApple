//
//  ViewController.swift
//  SignInWithAppleExample
//
//  Created by Nikita on 27/04/20.
//  Copyright © 2020 Nikita. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController,ASAuthorizationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        createSignInWithAppleButton()
        // Do any additional setup after loading the view.
    }
    
    func createSignInWithAppleButton(){
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        authorizationButton.frame = CGRect.init(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2 - 25, width: 200, height: 50)
        self.view.addSubview(authorizationButton);
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    // MARK: - ASAuthorizationControllerDelegate methods
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName ?? ""
            let userLastName = appleIDCredential.fullName?.familyName ?? ""
            let userEmail = appleIDCredential.email ?? ""
            print(userIdentifier,userFirstName,userLastName,userEmail)
            
            //Navigate to results view controller
            launchSuccessViewController(name: userFirstName)
            
        }
        else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print(username,password)

            //The app has received your selected credential from the keychain.
            launchSuccessViewController(name: username)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print(error)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func launchSuccessViewController(name:String){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let successVC = storyboard.instantiateViewController(identifier: "SuccessViewController") as! SuccessViewController
        successVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(successVC, animated: true, completion: nil)
        successVC.setUserName(name:name)
    }
    
}

