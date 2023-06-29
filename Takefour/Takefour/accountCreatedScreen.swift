//
//  accountCreatedScreen.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/10/23.
//

import UIKit
import Firebase

class accountCreatedScreen: UIViewController {
    
    @IBOutlet weak var returnToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func returnToLoginClicked(_ sender: Any) {
    }
    

}
