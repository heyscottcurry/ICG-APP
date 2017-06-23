//
//  LaunchVC.swift
//  Indianapolis Coffee Guide
//
//  Created by Scott Curry on 3/12/17.
//  Copyright © 2017 Scott Curry. All rights reserved.
//

import UIKit
import Firebase

class LaunchVC: UIViewController, UITextFieldDelegate {

    
    func letsGo() {
        if emailTextField.text == "" {
            print("Oops!")
        } else {
            // handleRegister()
        }
        
        let providedEmailAddress = emailTextField.text
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        
        
        if isEmailAddressValid
        {
            handleRegister()
            UIView.animate(withDuration: 0.3, animations: {
                self.underLine.backgroundColor = UIColor.green
                
            })
            self.emailLabel.text = "Sweet! You're in!"
            self.emailLabel.textColor = UIColor.green
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainNavVCViewController") as! mainNavVCViewController */
                // self.present(newViewController, animated: true, completion: nil)
                
                self.performSegue(withIdentifier: "showNotify", sender: self)
            })
        } else {
            self.emailLabel.text = "Whoops! Invalid email!"
            self.emailLabel.textColor = UIColor.yellow
            print("Email address is not valid")
        }

    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        letsGo()
            }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var getStartedBtn: UIButton!
    var passwordText = "password"
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    var comLine = false


   
    @IBAction func fieldEdit(_ sender: UITextField) {
        let labelOrigin = self.emailLabel.frame.origin.y
        
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.comLine == false {
            self.emailLabel.frame.origin.y = labelOrigin - 30
            self.comLine = true
            }
            self.underLine.backgroundColor = UIColor(displayP3Red: 217/255, green: 83/255, blue: 79/255, alpha: 1)
            self.getStartedBtn.layer.backgroundColor = UIColor(displayP3Red: 217/255, green: 83/255, blue: 79/255, alpha: 1).cgColor
            self.getStartedBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.getStartedBtn.layer.borderColor = UIColor(displayP3Red: 217/255, green: 83/255, blue: 79/255, alpha: 1).cgColor
          
            
            if self.view.frame.size.height < 600 {
             self.view.frame.origin.y -= self.view.frame.origin.y + 100
            }
        })
    }
    
    

    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.emailTextField.delegate = self
        self.getStartedBtn.layer.borderWidth = 2
        self.getStartedBtn.layer.borderColor = UIColor.white.cgColor
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    
        if self.view.endEditing(true) {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame.origin.y = self.view.frame.origin.y - 100
            })
            
        }
        
        
    }
    
    
    
    func handleRegister() {
        guard let email = emailTextField.text else {
        return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: passwordText, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print("Something isn't quite right")
                return
            }
            
            guard (user?.uid) != nil else {
            return
            }
            
            let ref = FIRDatabase.database().reference(fromURL: "https://icg-app.firebaseio.com/")
            let usersReference = ref.child("emails").child((user?.uid)!)
            let values = ["email": self.emailTextField.text]
            usersReference.updateChildValues(values as Any as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("Something went wrong with updated the variables")
                    return
                }
                
                print("Saved user successfully into FB database")
            })
            
        
        })
        print("123")
    }
 
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if self.view.frame.size.height < 600 {
            UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y -= self.view.frame.origin.y
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        letsGo()
        if self.view.frame.size.height < 600 {
            UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y -= self.view.frame.origin.y
            })
        }
        return(true)
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
