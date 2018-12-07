//
//  ProviderViewController.swift
//  Food
//
//  Created by student on 04.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//

import UIKit

class ProviderViewController: UIViewController {
    
    @IBOutlet private weak var collectionView : UICollectionView!
    @IBOutlet private weak var inputText : UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var comments = ["Good provider", "Nice", "The best"]

    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.becomeFirstResponder()
        scrollView.contentSize = self.view.bounds.size
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        //Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func sendButtonTaped(button : UIButton)
    {
        print("The comment was sent")
        inputText.resignFirstResponder()
    }
    
    @IBAction func endComment(_ sender: Any) {
        inputText.updateFocusIfNeeded()        
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
}
extension ProviderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = comments[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
}
