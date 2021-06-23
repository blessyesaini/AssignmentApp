//
//  ViewController.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextarea: UITextView!
    @IBOutlet weak var visaTypeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet weak var subscriptionImageView: UIImageView!
    
    var isSubscription: Bool = false
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
    let visaTypePicker = UIPickerView()
    let visaTypeData: [String] = ["3 Months", "6 Months", "1 Year", "2 Year", "Other"]
    
    //MARK: - view lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initProcess()
        // Do any additional setup after loading the view.
    }
    //MARK: - set values initially

    fileprivate func initProcess() {
        
        self.resetValues()
        
        visaTypePicker.delegate = self
        visaTypePicker.dataSource = self
        
        visaTypeTextField.inputView = visaTypePicker
        
        descriptionTextarea.delegate = self
        
        for button in actionButtons {
            
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            
        }
    }
    //MARK: - clear data on either clear button click or initial view load

    func resetValues() {
        self.emailTextField.text = ""
        self.descriptionTextarea.text = ""
        self.visaTypeTextField.text = ""
        if #available(iOS 13.0, *) {
            subscriptionImageView.image = UIImage(systemName: "squareshape")
        } else {
            // Fallback on earlier versions
            subscriptionImageView.image = UIImage(named: "checkbox")
        }
        isSubscription = false
    }
    
   
    //MARK: - email button tapped mthod

    @IBAction func onClickEmailSubscriptionTapped(_ sender: Any) {
        if #available(iOS 13.0, *) {
            if subscriptionImageView.image == UIImage(systemName: "squareshape") {
                isSubscription = true
                
                subscriptionImageView.image = UIImage(systemName: "checkmark.square.fill")
            } else {
                isSubscription = false
                subscriptionImageView.image = UIImage(systemName: "squareshape")
                
            }
        } else {
            // Fallback on earlier versions
            if subscriptionImageView.image ==  #imageLiteral(resourceName: "checkbox"){
                isSubscription = true
                
                subscriptionImageView.image = #imageLiteral(resourceName: "checkboxfilled")
            } else {
                isSubscription = false
                subscriptionImageView.image = #imageLiteral(resourceName: "checkbox")
                
            }
        }
    }
    
    
    //MARK: - clear button tapped

    @IBAction func clearButtonTapped(_ sender: Any) {
        resetValues()
    }
    //MARK: - save button tapped

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let email = self.emailTextField.text,
              email.count != 0,
              let visaType = self.visaTypeTextField.text,
              visaType.count != 0,
              let desc = self.descriptionTextarea.text,
              desc.count != 0 else {
            
            GeneralHandler.shared.showAlert(controller: self, message: "Please Enter All datas", infoImage: #imageLiteral(resourceName: "Burj-Khalifa"))
            
            return
        }
        
        if GeneralHandler.shared.isValidEmail(email) {
            
            let newEnquiry = Enqries(email: email, subscription: self.isSubscription, visaTypes: visaType, description: desc)
            
            
            let request = UserActivitiesRequest()
            SessionHandlers.sessionHandler(url: request.getURL(), parameters: request.getParams(enquries: newEnquiry), method: .post) { response in
                
                DispatchQueue.main.async {
                    if response.status {
                        GeneralHandler.shared.showAlert(controller: self, message: "Data Saved Successfully!!!", infoImage: #imageLiteral(resourceName: "alert"))
                        //Save data to Core Data
                        DatabaseHandler.shared.createEnqury(newEnquiry: newEnquiry) { status in
                            if status {
                                self.resetValues()
                            }
                        }
                    }
                }
                
                
            }
        } else {
            GeneralHandler.shared.showAlert(controller: self, message: "Invalid Email Address. Please check email address.", infoImage: #imageLiteral(resourceName: "alert"))
            
        }
    }
}
//MARK: - picker view delegate and datasource methods

extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return visaTypeData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return visaTypeData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        visaTypeTextField.text = visaTypeData[row]
    }
}

//MARK: - textview delegate method

extension FormViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = text.components(separatedBy: cs).joined(separator: "")
        
        return (text == filtered)
    }
    
}


