//
//  signupScreen.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/9/23.
//

import UIKit
import Firebase

class signupScreen: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       let nextTag = textField.tag + 1
       // Try to find next responder
       let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?

       if nextResponder != nil {
           // Found next responder, so set it
           nextResponder?.becomeFirstResponder()
       } else {
           // Not found, so remove keyboard
           textField.resignFirstResponder()
       }

       return false
   }
    
    
    @IBAction func signupClicked(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }
            else {
                // Go to our home screen
            }
        }
    }

}
