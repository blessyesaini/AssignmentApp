//
//  UserTableViewCell.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import UIKit
import  CoreData
class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        initProcess()
    }
    
    fileprivate func initProcess() {
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        
        descLabel.sizeToFit()
        descLabel.numberOfLines = 0
    }
    
    func loadDatas(isOffline: Bool,offlineData: Any ) {
        
        if isOffline {
            if let offlineUserData = offlineData as? NSManagedObject {
                titleLabel.text = offlineUserData.value(forKey: "email") as? String
                descLabel.text = offlineUserData.value(forKey: "descriptioninfo") as? String
            }
        } else {
            if let onlineUserData = offlineData as? UserModel {
                titleLabel.text = onlineUserData.title
                descLabel.text = onlineUserData.body
            }
        }
    }
    
}
