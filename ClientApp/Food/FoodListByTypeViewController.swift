//
//  FoodListByTypeViewController.swift
//  Food
//
//  Created by student on 27.11.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit
import CoreData

//struct bigi {
//    var name: String
//    var amount: Float
//    var detail: String
//    var hotcold: Bool
//    var type: String
//
//    init(name: String, amount: Float, detail: String, hotcold: Bool, type: String) {
//        self.name = name
//        self.amount = amount
//        self.detail = detail
//        self.hotcold = hotcold
//        self.type = type
//    }
//}

class FoodListByTypeViewController: UIViewController {

    @IBOutlet private weak var collectionView : UICollectionView!

    //var booom : [bigi] = []
    var dishes : [Inventory] = []
    var collectionData: [String] = ["Chiken", "Beef"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 2                       // width of the single column
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: max(200, width))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewSegue" {
            if let dest = segue.destination as? DetailsViewController,
                let index = collectionView.indexPathsForSelectedItems?.first! {
                      dest.selection = dishes[index.row].name
                      dest.amount = dishes[index.row].amount
                      dest.hotcold = dishes[index.row].hotcold
                      dest.detail = dishes[index.row].detail
                    dest.id = dishes[index.row].id
                dest.photoUrl = dishes[index.row].photo
                
            }
        }
    }

}
extension FoodListByTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = dishes[indexPath.row].name
        }
        if let label = cell.viewWithTag(99) as? UILabel {
            label.text = String(dishes[indexPath.row].amount)
        }
        if let imageDish = cell.viewWithTag(50) as? UIImageView {
            if let url = dishes[indexPath.row].photo {
                imageDish.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "DetailsViewSegue", sender: indexPath)
//    }
}
