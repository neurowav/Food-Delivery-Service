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
    @IBOutlet private weak var detailsLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = selection
    }


}
