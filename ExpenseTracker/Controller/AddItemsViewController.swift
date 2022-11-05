//
//  AddItemsViewController.swift
//  ExpenseTracker
//
//  Created by emre usul on 20.10.2022.
//

import UIKit



class AddItemsViewController: UIViewController {

    var Items = ItemsModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var setupviewController = SetupViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "addItemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        
        tableView.layer.cornerRadius = 7
    }
    
    @IBAction func segmentedController(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        Items.getSegmentNumber(index)
        tableView.reloadData()
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - TableView Delegate and Datasource

extension AddItemsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.getRowNumber()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! addItemTableViewCell
        cell.addItemLabel.text = Items.getItems(indexPath.row).title
        cell.addItemImageView.image = UIImage(named: Items.getItems(indexPath.row).image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Items.getHeaderTitle()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Items.getHeightForHeader())
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.white
        header?.textLabel?.text = Items.getHeaderTitle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Items.getSetupIndex(indexPath.row)
        performSegue(withIdentifier: "goToSetup", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SetupViewController
        DispatchQueue.main.async {
            destinationVC.label.text = self.Items.getSetup().title
            destinationVC.itemImage.image = UIImage(named: self.Items.getSetup().image)
            destinationVC.segmentNumber = self.segmentedControl.selectedSegmentIndex
        }
        
        
    }
    
    
}


