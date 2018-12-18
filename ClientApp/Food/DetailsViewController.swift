//
//  DetailsViewController.swift
//  Food
//
//  Created by Misha on 26/11/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var selection: String!
    var amount: Float!
    var hotcold: Bool!
    var detail: String!
    var id: Int64!
    var photoUrl: String!
    @IBOutlet private weak var detailsLabel : UILabel!
    
    @IBOutlet weak var imageImg: UIImageView!
    @IBOutlet weak var ingrLabel: UILabel!
    @IBOutlet weak var providerLabel: UIButton!
    @IBOutlet weak var hotcoldLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = selection
        hotcoldLabel.text = String(hotcold)
        amountLabel.text = String(amount)
        ingrLabel.text = detail
        imageImg.loadImageUsingCacheWithURLString(photoUrl, placeHolder: UIImage(named: "placeholder"))
    }

    @IBAction func addToOrder(_ sender: Any) {
        let Url = String(format: "https://tranquil-garden-63874.herokuapp.com/orders")
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
    }
    
}
