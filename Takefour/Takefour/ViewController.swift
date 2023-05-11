//
//  ViewController.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/9/23.
//

import UIKit



// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "loginScreen") as! loginScreen
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "signupScreen") as! signupScreen
        self.navigationController?.pushViewController(storyboard, animated: true)
    }

}

