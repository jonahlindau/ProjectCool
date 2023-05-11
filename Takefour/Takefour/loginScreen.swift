//
//  openingScreen.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/9/23.
//

import UIKit
import Firebase




class loginScreen: UIViewController {

    // Creating outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //overriding dark mode
        overrideUserInterfaceStyle = .light
        
        //allowing keyboard to be closed by tapping anywhere on screen
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    //toggle hidden password button
    var iconClick = true
    
    @IBAction func showPasswordClicked(_ sender: AnyObject) {
        if iconClick {
                passwordTextField.isSecureTextEntry = false
            } else {
                passwordTextField.isSecureTextEntry = true
            }
            iconClick = !iconClick
    }
    
    //login button
    @IBAction func loginClicked(_ sender: Any) {

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
            
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else {
                // Go to our home screen
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
        }
    }
    

}
