//
//  ItemsModel.swift
//  ExpenseTracker
//
//  Created by emre usul on 23.10.2022.
//

import Foundation


struct ItemsModel {
    
    var segmentNumber = 0
    var setupIndex = 0
    
    
    
    let incomes = [Item(title: "Salary", image: "salary"),
                   Item(title: "Other Incomes", image: "otherincomes")
    ]
    
    let expenses = [Item(title: "Shopping", image: "shopping"),
                    Item(title: "Food", image: "food"),
                    Item(title: "Transportation", image: "transportation"),
                    Item(title: "Clothes", image: "clothes"),
                    Item(title: "Home", image: "home"),
                    Item(title: "Sport", image: "sports"),
                    Item(title: "Entertainment", image: "entertainment"),
                    Item(title: "Credits", image: "credit-card")
    ]
    
    mutating func getSegmentNumber(_ segmentIndex:Int) {
        segmentNumber = segmentIndex
    }
    
    func getRowNumber() -> Int {
        
        if segmentNumber == 0 {
            return incomes.count
        }
        
        else {
            return expenses.count
        }
    }
    
    mutating func getSetupIndex(_ indexpath:Int) {
        setupIndex = indexpath
    }
    
    func getItems(_ indexpath:Int) -> Item {
        
        if segmentNumber == 0 {
            return incomes[indexpath]
        } else {
            return expenses[indexpath]
        }
    }
    
    func getHeaderTitle() -> String {
        return "Categories"
    }
    
    func getHeightForHeader() -> Int {
        return 30
    }
    
    
    func getSetup() -> Item {
        
        if segmentNumber == 0 {
            return incomes[setupIndex]
        } else {
            return expenses[setupIndex]
        }
    }
    
    
    
}
