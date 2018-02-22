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
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        alertController = UIAlertController(title: "Empty Text Fields", message: "Please enter your message", preferredStyle: .alert)
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        // Do any additional setup after loading the view.
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
        cell.textLabel?.text = chatMessages[indexPath.row]["text"] as? String
        /*cell.userLabel.text = messages[indexPath.row]["user"] as? String*/
        return cell
        
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        
        query.findObjectsInBackground() {
            (post: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print(post)
                if let post = post{
                    self.chatMessages = post
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
        // The getObjectInBackgroundWithId methods are asynchronous, so any code after this will run
        // immediately.  Any code that depends on the query result should be moved
        // inside the completion block above.
        
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
