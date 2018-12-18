//
//  APIService.swift
//  Food
//
//  Created by Misha on 13/12/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import Foundation
import UIKit

class APIServiceOrder: NSObject {
    let query = "dishes"
    lazy var endpoint: String = {
        return "https://tranquil-garden-63874.herokuapp.com/orders/1"
    }()
    
    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        let urlString = endpoint
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["inventories"] as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
}
