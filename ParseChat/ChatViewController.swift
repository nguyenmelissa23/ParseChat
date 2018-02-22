//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Melissa Phuong Nguyen on 2/21/18.
//  Copyright © 2018 Melissa Phuong Nguyen. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var textInputField: UITextField!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
