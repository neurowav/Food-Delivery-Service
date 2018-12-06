//
//  ViewController.swift
//  Food
//
//  Created by Misha on 26/11/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit

public struct Food {
    var type : String
    var foodList : [String]
    
    init(type: String,
        foodList: [String]) {
        
        self.type = type
        self.foodList = foodList
    }
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView : UICollectionView!
    
    var collectionData : [Food] = [Food(type: "🍗", foodList: ["Chicken", "Beefy"]), Food(type: "🍔", foodList: ["Big Mac", "Burger"]), Food(type: "🥤", foodList: ["Cola", "Fanta", "Beer"]), Food(type: "🥣", foodList: ["Soup", "Sauce"])]
    
    //var collectionData = ["🍗", "🍔", "🥤", "🥣"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 2                       // width of the single column
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = collectionView.indexPathsForSelectedItems?.first
        if segue.identifier == "FoodByTypeSegue" {
            if let dest = segue.destination as? FoodListByTypeViewController {
                dest.collectionData = collectionData[cell!.row].foodList
            }
        }
    }
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = collectionData[indexPath.row].type
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
//    }
    
    
}
