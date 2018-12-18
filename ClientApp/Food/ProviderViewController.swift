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
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var comments = ["Good provider, the pizza was awesome. Wait for another order", "Nice", "The best", "Wow", "Awesome", "Sick"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.contentSize = self.view.bounds.size
        
        ListenKeyboardEvents()
    
        tableView.reloadData()
        cvHeight.constant = tableView.contentSize.height
        print(cvHeight.constant)
    }
    
    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//
//        for i in 0..<comments.count {
//            let size = tableView.rectForRow(at: IndexPath(row: i, section: 0)).height
//            print(size)
//        }
//        print("\(cvHeight.constant)")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          cvHeight.constant = tableView.contentSize.height
    }
    
    func ListenKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: Notification.Name.UIKeyboardWillShow/*UIResponder.keyboardWillShowNotification*/, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: Notification.Name.UIKeyboardWillHide /*UIResponder.keyboardWillHideNotification*/, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame /*UIResponder.keyboardWillChangeFrameNotification*/, object: nil)
    }
    deinit {
        //Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow /*UIResponder.keyboardWillShowNotification*/, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide /*UIResponder.keyboardWillHideNotification*/, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame /*UIResponder.keyboardWillChangeFrameNotification*/, object: nil)
    }
    
    @IBAction func sendButtonTaped(button : UIButton)
    {
        if inputText.text != "" {
            print("The comment was sent")
            inputText.resignFirstResponder()
            comments.append(inputText.text!)
            tableView.reloadData()
            inputText.text?.removeAll()
            cvHeight.constant = tableView.contentSize.height
            print(comments)
        }
    }
    
    @IBAction func endComment(_ sender: Any) {
        inputText.updateFocusIfNeeded()        
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey/*UIResponder.keyboardFrameEndUserInfoKey*/] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow/*UIResponder.keyboardWillShowNotification*/ || notification.name == Notification.Name.UIKeyboardWillChangeFrame/*UIResponder.keyboardWillChangeFrameNotification*/ {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
}

extension ProviderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as! TvCell
        cell.setupr(comments[indexPath.row])
        return cell
    }
}

class TvCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func setupr(_ text: String) {
        label.text = text
        //layoutIfNeeded()
    }
    
}
