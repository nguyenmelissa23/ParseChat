//
//  ViewController.swift
//  ParseChat
//
//  Created by Melissa Phuong Nguyen on 2/21/18.
//  Copyright © 2018 Melissa Phuong Nguyen. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        alertController = UIAlertController(title: "Empty Text Fields", message: "Please enter username or password", preferredStyle: .alert)
        
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
    }

    
    @IBAction func onSignup(_ sender: Any) {
        if ((usernameLabel.text?.isEmpty)! && (passwordLabel.text?.isEmpty)!) || (usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)! {
            present(alertController, animated: true)
        }else {
            registerUser()
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if ((usernameLabel.text?.isEmpty)! && (passwordLabel.text?.isEmpty)!) || (usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)! {
            present(alertController, animated: true)
        }else {
            loginUser()
        }
    }

    func registerUser() {
        let newUser = PFUser()
        newUser.username = usernameLabel.text
        newUser.password = passwordLabel.text
        newUser.signUpInBackground { (success: Bool? , error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User registered successfully!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func loginUser() {
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

