//
//  FoodListByTypeViewController.swift
//  Food
//
//  Created by student on 27.11.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit

class FoodListByTypeViewController: UIViewController {

    @IBOutlet private weak var collectionView : UICollectionView!

    var collectionData = ["Chicken", "Beefy"] //updates with new values when concrete cell is taped
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 2                       // width of the single column
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewSegue" {
            if let dest = segue.destination as? DetailsViewController,
                let index = sender as? IndexPath {
                dest.selection = collectionData[index.row]
            }
        }
    }

}
extension FoodListByTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = collectionData[indexPath.row]
        }
        return cell
    }
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    performSegue(withIdentifier: "DetailsViewSegue", sender: indexPath)
    //}
}
