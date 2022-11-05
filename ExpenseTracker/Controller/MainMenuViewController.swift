//
//  MainMenuViewController.swift
//  ExpenseTracker
//
//  Created by emre usul on 9.10.2022.
//

import UIKit
import CoreData

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var incomesView: UIView!
    @IBOutlet weak var expensesView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var incomesAmount: UILabel!
    @IBOutlet weak var expensesAmount: UILabel!
    @IBOutlet weak var totalCurrent: UILabel!
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var history = HistoryModel()
    var addItemManager = AddItemsViewController()
    let defaults = UserDefaults.standard
    
    
    var newIncomes = 0.0
    var newExpenses = 0.0
    var incomes = 0.0
    var expenses = 0.0
    var current = 0.0
    var newCurrent = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupLabel()
    
        
       
        history.loadCategories()

        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        tableView.dataSource = self
        tableView.delegate = self
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData(data:segmentNumber:)), name: NSNotification.Name("getDataID"), object: nil)
    
    }
    
    @objc func getData(data:Notification,segmentNumber:Notification) {

        if let userInfo = data.userInfo {
            
            let amount = userInfo["label"] as! Double
            let segment = userInfo["segment"] as! Int
            
            if segment == 0 {
                newIncomes = history.getTotalIncomes(amount) + incomes
                self.defaults.set(newIncomes, forKey: "Income")
                self.incomesAmount.text = "$\(String(newIncomes))"
                newCurrent = history.getTotalCurrent(segment, amount) + current
                self.defaults.set(newCurrent, forKey: "current")
                
            } else  {
                newExpenses = history.getTotalExpenses(amount) + expenses
                self.defaults.set(newExpenses, forKey: "Expense")
                self.expensesAmount.text = "$\(String(newExpenses))"
                newCurrent = history.getTotalCurrent(segment, amount) + current
                self.defaults.set(newCurrent, forKey: "Current")
            }
                          
            if newCurrent > 0 {
                totalCurrent.text = "$\(String(newCurrent))"
            } else {
                totalCurrent.text = "-$\(String(-newCurrent))"
            }
              
            totalCurrent.textColor = history.textColor(total: newCurrent)
        }
        
    }
    
    func setupLabel() {
        incomes = defaults.double(forKey: "Income")
        incomesAmount.text = "$\(String(incomes))"
        expenses = defaults.double(forKey: "Expense")
        expensesAmount.text = "$\(String(expenses))"
        current = defaults.double(forKey: "Current")
        
        if current >=  0 {
            totalCurrent.text = "$\(String(current))"
        } else {
            totalCurrent.text = "-$\(String(-current))"
        }
        
    }

    
    func setupViews() {
        incomesView.layer.cornerRadius = 20
        expensesView.layer.cornerRadius = 20
        tableView.layer.cornerRadius = 20
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addItem", sender: self)
    }
    

    
}


//MARK: - TableView Delegate and Datasource
extension MainMenuViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        heightConstant.constant = CGFloat(history.getHeightConstant())
        DispatchQueue.main.async {
            tableView.reloadData()
        }
       
        return history.getRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.actionLabel.text = history.getHistory(indexPath.row).title
        cell.actionAmount.text = "$\(Double(history.getHistory(indexPath.row).cost!)!)"
        cell.actionImage.image = UIImage(data: history.getHistory(indexPath.row).image!)
        cell.dateLabel.text = history.getHistory(indexPath.row).date
        

        return cell
    }
    
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "History"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
   
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.white
        header?.textLabel?.text = "History"
    }
    


    
   
}


