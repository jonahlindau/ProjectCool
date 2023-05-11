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
        self.performSegue(withIdentifier: "returnToInitial", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
