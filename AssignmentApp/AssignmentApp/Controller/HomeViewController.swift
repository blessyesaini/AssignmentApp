//
//  HomeViewController.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet  var actionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initProcess()
        // Do any additional setup after loading the view.
    }
    //MARK: - initialisation method

    fileprivate func initProcess() {
        
        for button in actionButtons {
            
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            
        }
    }

}
