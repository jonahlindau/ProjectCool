//
//  homeScreen.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/10/23.
//

import UIKit

class homeScreen: UIViewController {
    

    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var livebetsView: UIView!
    @IBOutlet weak var leaguesView: UIView!
    @IBOutlet weak var betslipView: UIView!
    @IBOutlet weak var sportsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func homeButton(_ sender: Any) {
        self.homeView.alpha = 1
        self.livebetsView.alpha = 0
        self.leaguesView.alpha = 0
        self.betslipView.alpha = 0
        self.sportsView.alpha = 0
    }
    
    @IBAction func livebetsButton(_ sender: Any) {
        self.homeView.alpha = 0
        self.livebetsView.alpha = 1
        self.leaguesView.alpha = 0
        self.betslipView.alpha = 0
        self.sportsView.alpha = 0
    }
    
    @IBAction func leaguesButton(_ sender: Any) {
        self.homeView.alpha = 0
        self.livebetsView.alpha = 0
        self.leaguesView.alpha = 1
        self.betslipView.alpha = 0
        self.sportsView.alpha = 0
    }
    
    @IBAction func betslipButton(_ sender: Any) {
        self.homeView.alpha = 0
        self.livebetsView.alpha = 0
        self.leaguesView.alpha = 0
        self.betslipView.alpha = 1
        self.sportsView.alpha = 0
    }
    
    @IBAction func sportsButton(_ sender: Any) {
        self.homeView.alpha = 0
        self.livebetsView.alpha = 0
        self.leaguesView.alpha = 0
        self.betslipView.alpha = 0
        self.sportsView.alpha = 1
    }
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue){}

}
