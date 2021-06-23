//
//  GeneralHandler.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import Foundation
import Reachability

struct Enqries {
    let email: String
    let subscription:Bool
    let visaTypes: String
    let description: String
}
enum AppCells: String {
    case userTableviewCell = "UserTableViewCell"
    case userEntity = "User"
    func getName() -> String {
        return self.rawValue
    }
}
class GeneralHandler: NSObject {
    
    static let shared:GeneralHandler = GeneralHandler()
    
    //MARK: - Network connection check

     func testConnection() -> Bool {
        
        var networkstatus = false
        let reachability = try? Reachability(hostname: "www.apple.com")
        
        switch reachability?.connection {
        case .wifi, .cellular:
            networkstatus = true
            break
            
        default:
            networkstatus = false
            break
        }
        
        if !networkstatus {
            DispatchQueue.main.async {
            }
        }
        
        return networkstatus
    }
    
    //MARK: - valid email check

     func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - alert view controller display

     func showAlert(controller: UIViewController?, message:String, infoImage: UIImage){
        
        if let alertPresentController = controller{
            
            let validationLinkAlert = UIAlertController(title: "", message:"\n \n \n \n \n" + message, preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            validationLinkAlert.addAction(dismissAction)
            
            let imageviewLogo = UIImageView(frame: CGRect(x: 105 , y: 15, width: 60, height: 60))
            imageviewLogo.contentMode = .scaleAspectFit
            imageviewLogo.backgroundColor = UIColor.clear
            imageviewLogo.image = infoImage
            
            validationLinkAlert.view.addSubview(imageviewLogo)
            alertPresentController.present(validationLinkAlert, animated: true, completion: nil)
        }
    }
   
}
