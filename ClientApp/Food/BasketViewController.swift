//
//  BasketViewController.swift
//  Food
//
//  Created by student on 18.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

struct FoodList {
    var name: String
    var amount: Float
    var id: Int64
    
    init(name: String, amount: Float, id: Int64) {
        self.amount = amount
        self.name = name
        self.id = id
    }
}

import UIKit

class BasketViewController: UITableViewController {

    @IBOutlet weak var totalAmount: UILabel!
    var dish : [FoodList] = []
    var dishTotal : Float = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let serviceInventory = APIServiceOrder()
        serviceInventory.getDataWith{ (result) in
            switch result {
            case .Success(let data):
                let dictionary = data
                dictionary.forEach{ dict in
                    self.dish.append(self.InitFoodlist(dictionary: dict))
                    self.dish.forEach{ d in
                        self.dishTotal += d.amount
                    }
                }
            case .Error(let message):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Error", message: message)
                }
            }
        }

       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    private func InitFoodlist(dictionary: [String: AnyObject]) -> FoodList {
        let amount = dictionary["amount"] as! NSNumber
        let am = amount.floatValue
        let name = dictionary["name"] as! String
        let id = dictionary["id"] as! NSNumber
        let nid = id.int64Value
        return FoodList(name: name, amount: am, id: nid)
    }

    
}

extension BasketViewController: DishCellDelegate {
    func disgCellDidTapDelete(_ sender: DishCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let id = dish[tappedIndexPath.row].id
        let Url = String(format: "https://tranquil-garden-63874.herokuapp.com/orders/delete")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["inventory_id" : id]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
            }
            }.resume()
        dish.remove(at: tappedIndexPath.row)
        tableView.deleteRows(at: [tappedIndexPath], with: .automatic)
        dishTotal = 0
        dish.forEach{ d in
            dishTotal += d.amount
        }
        totalAmount.text = String(dishTotal)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dish.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        totalAmount.text = String(dishTotal)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath) as! DishCell
     
        cell.setup(dish[indexPath.row].name, dish[indexPath.row].amount)
        cell.delegate = self
        return cell
    }
}


class DishCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var deleteCell: UIButton!
    
    func setup( _ name: String, _ amount: Float) {
        nameLabel.text = name
        priceLabel.text = String(amount)
    }
    
    weak var delegate: DishCellDelegate?
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        delegate?.disgCellDidTapDelete(self)
    }
}

protocol DishCellDelegate : class {
    func disgCellDidTapDelete(_ sender: DishCell)
}
