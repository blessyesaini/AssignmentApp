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
    //MARK: - initialisation methods

    fileprivate func initProcess() {
        
        for button in actionButtons {
            
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            
        }
    }
    //MARK: - new enquiry tapped

    @IBAction func newEnquiryTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let formVC = self.storyboard?.instantiateViewController(identifier: Controllers.formViewController.getName()) as! FormViewController
            self.navigationController?.pushViewController(formVC, animated: true)
        } else {
            // Fallback on earlier versions
            let formVC = self.storyboard?.instantiateViewController(withIdentifier: Controllers.formViewController.getName()) as! FormViewController
            self.navigationController?.pushViewController(formVC, animated: true)
        }
       
    }
    //MARK: - view existing list tapped

    @IBAction func viewEnquiryTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let formVC = self.storyboard?.instantiateViewController(identifier: Controllers.userListVieController.getName()) as! UsersListViewController
            self.navigationController?.pushViewController(formVC, animated: true)
        } else {
            // Fallback on earlier versions
            let formVC = self.storyboard?.instantiateViewController(withIdentifier: Controllers.userListVieController.getName()) as! UsersListViewController
            self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
}
