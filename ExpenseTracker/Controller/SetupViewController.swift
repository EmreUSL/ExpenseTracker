//
//  SetupViewController.swift
//  ExpenseTracker
//
//  Created by emre usul on 21.10.2022.
//

import UIKit



class SetupViewController: UIViewController {
    
    var history = HistoryModel()
    let date = Date()
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var amountTextField: UITextField!
    var segmentNumber:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        // Do any additional setup after loading the view.
    }
    
    func setupDefault() {
        amountTextField.becomeFirstResponder()
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        history.getNewHistory(History(title: label.text!, image: itemImage.image! , cost: amountTextField.text!, date: dateFormatter.string(from: date)))
        
        if amountTextField.text != "" {
        NotificationCenter.default.post(name: NSNotification.Name("getDataID"), object: nil, userInfo: ["segment":segmentNumber!,"label":Double(amountTextField.text!)!])
        self.dismiss(animated: true,completion: nil)
        }
    }
    
    
}


