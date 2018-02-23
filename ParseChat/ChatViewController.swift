//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Melissa Phuong Nguyen on 2/21/18.
//  Copyright © 2018 Melissa Phuong Nguyen. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    
    
    var alertController: UIAlertController!
    var chatMessages: [PFObject] = []
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        alertController = UIAlertController(title: "Empty Text Fields", message: "Please enter your message", preferredStyle: .alert)
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }

        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        alertController.addAction(OKAction)

    }
    
    @IBAction func onSendMessage(_ sender: Any) {
        if (textInputField.text?.isEmpty)! {
            present(alertController, animated: true)
        } else {
            saveMessage()
        }
    }
    
    func saveMessage() {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = textInputField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success: Bool? , error: Error? ) in
            if success! {
                print("The message was saved")
                self.textInputField.text = ""
            } else if let error = error {
                print("Problem saving message:\(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            self.tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let chatmessage = chatMessages[indexPath.row]
        cell.messageLabel.text = chatmessage["text"] as? String
//        cell.messageLabel.text = chatmessage["text"] as? String
        if let user = chatmessage["user"] as? PFUser {
            cell.userLabel.text = "\(user["username"]!)"
            print("USERNAME IS", "\(user["username"]!)" )

        } else {
            print("No username")
            cell.userLabel.text = "🤖"
        }
//
        return cell

    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground() {
            (post: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print(post!)
                if let post = post{
                    self.chatMessages = post
                    self.tableView.reloadData()
                }
            } else {
                print(error!)
            }
        }

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
