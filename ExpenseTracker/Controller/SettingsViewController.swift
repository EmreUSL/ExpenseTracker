//
//  SettingsViewController.swift
//  ExpenseTracker
//
//  Created by emre usul on 16.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let settings = Settings()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    

    
}

extension SettingsViewController: UITableViewDelegate , UITableViewDataSource {
        
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.settings[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.layer.cornerRadius = 7
        cell.backgroundColor = .lightGray
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = settings.settings[indexPath.section][indexPath.row]
        return cell
    }
    
    
}
