//
//  ViewController.swift
//  Food
//
//  Created by Misha on 26/11/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView : UICollectionView!
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        //frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 2                       // width of the single column
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        do {
            try self.fetchedResultController.performFetch()
            print("COUNT FETCHED FIRST: \(String(describing: self.fetchedResultController.sections?[0].numberOfObjects))")
        } catch let error {
            print("Error: \(error)")
        }
        
        let serviceInventory = APIServiceInventory()
        serviceInventory.getDataWith{ (result) in
            switch result {
            case .Success(let data):
                self.clearData()
                self.saveInCoreDataWith(array: data)
                print(data)
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = collectionView.indexPathsForSelectedItems?.first
        if segue.identifier == "FoodByTypeSegue" {
            if let dest = segue.destination as? FoodListByTypeViewController {
                let inventoryPizza: [Inventory] = {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
                    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
                    var iPizza: [Inventory] = []
                    do {
                        let inventories = try frc.managedObjectContext.fetch(fetchRequest) as! [Inventory]
                        iPizza = inventories.filter {inv in
                            inv.type == "pizza"
                        }
                    } catch {
                        let fetchError = error as NSError
                        print(fetchError)
                    }
                    return iPizza
                }()
                
                let inventoryMeat: [Inventory] = {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
                    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
                    var iMeat: [Inventory] = []
                    do {
                        let inventories = try frc.managedObjectContext.fetch(fetchRequest) as! [Inventory]
                        iMeat = inventories.filter {inv in
                            inv.type == "meat"
                        }
                    } catch {
                        let fetchError = error as NSError
                        print(fetchError)
                    }
                    return iMeat
                }()
  
                if cell!.row == 0 {
                    dest.dishes = inventoryMeat
                }
                else if cell!.row == 1 {
                   dest.dishes = inventoryPizza
                  
                }
                    print(inventoryPizza)
                    print(dest.dishes)
                
                //if let inventory = fetchedResultController.object(at: cell!) as? Inventory {
            }
        }
    }
    
    private func createInventoryEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let inventoryEntity = NSEntityDescription.insertNewObject(forEntityName: "Inventory", into: context) as? Inventory {
            
            let amount = dictionary["amount"] as? NSNumber
            let id = dictionary["id"] as? NSNumber
            inventoryEntity.type = dictionary["type"] as? String
            inventoryEntity.name = dictionary["name"] as? String
            inventoryEntity.amount = amount!.floatValue
            inventoryEntity.detail = dictionary["detail"] as? String
            inventoryEntity.hotcold = dictionary["hotcold"] as! Bool
            inventoryEntity.photo = dictionary["photo"] as? String
            inventoryEntity.id = id!.int64Value
            
//            dishes?.forEach { dish in
//                let name = dish["name"] as? String
//                let detail = dish["detail"] as? String//,
//                let amount = dish["amount"] as? NSNumber//,
//                let type = dish["type"] as? String
//
                //,
                //let hotcold = dish["hotcold"] as? Bool
//            }
            return inventoryEntity
        }
        return nil
    }
    
    private func saveInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{self.createInventoryEntityFrom(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    private func clearData() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Inventory.self))
            do {
                let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR INVENTORY DELETING : \(error)")
            }
        }
    }
}

extension ViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else {
            return
        }
        
        switch (type) {
        case .insert:
            collectionView.insertItems(at: [cellIndex])
        case .delete:
            collectionView.deleteItems(at: [cellIndex])
        default:
            break
        }

    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
        //return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        
        if let inventory = fetchedResultController.object(at: indexPath) as? Inventory {
            if let label = cell.viewWithTag(100) as? UILabel {
                label.text = inventory.type
                }
        }
        return cell
    }
}
