//
//  HistoryModel.swift
//  ExpenseTracker
//
//  Created by emre usul on 24.10.2022.
//

import Foundation
import CoreData
import UIKit


var historiesArray = [Histories]()


let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let defaults = UserDefaults.standard

struct HistoryModel {

    var totalIncomes = 0.0
    var totalExpenses = 0.0
    var currentTotal = 0.0
    
    
    func getRowInSection() -> Int {
        historiesArray.count
    }
    
    func getHeightConstant() -> Double {
        
        if historiesArray.count == 0 {
            return 0
        } else {
            let heightConstant = (Double(historiesArray.count) * 90) + 40
            return heightConstant
        }
    }
    
    func getNewHistory(_ newHistory:History) {
        
        let newHistories = Histories(context: context)
        newHistories.title = newHistory.title
        newHistories.date = newHistory.date
        newHistories.cost = newHistory.cost
        
        let imageData = newHistory.image.pngData()
        newHistories.image = imageData
        
        saveCategories()
        
        historiesArray.append(newHistories)
   
    }
    
    func getHistory(_ indexpath:Int) -> Histories{
        return historiesArray[indexpath]
    }
    
    mutating func getTotalIncomes(_ incomes:Double) -> Double {
         totalIncomes += incomes
         return totalIncomes
    }
    
    mutating func getTotalExpenses(_ expenses:Double) -> Double {
        totalExpenses += expenses
        return totalExpenses
    }
    
    mutating func getTotalCurrent (_ segment:Int , _ total:Double) -> Double {
        if segment == 0 {
            currentTotal += total
            return currentTotal
        } else {
            currentTotal -= total
            return currentTotal
        }
    }
    
    
    func textColor(total:Double) -> UIColor {
        let new = currentTotal+total
        if new < 0 {
            return UIColor.systemRed
        } else if new > 0 {
            return UIColor.systemGreen
        } else {
            return UIColor.white
        }
    }
    
    
    
    
    
    
    //MARK: -  Core Data Functions
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print(error)
        }
       
    }
    
     func loadCategories() {
        
        let request : NSFetchRequest<Histories> = Histories.fetchRequest()

        do {
            historiesArray =  try context.fetch(request)
        } catch {
            print(error)
        }
    
    }
    
   
}


