//
//  ViewController.swift
//  MobeWash
//
//  Created by Sean Ippolito on 4/16/17.
//
//

import UIKit
import FacebookLogin
import Google
import GoogleSignIn
import Alamofire

class HomeViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    var btnSignIn : GIDSignInButton!

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        //get request
        Alamofire.request("http://localhost:8080/user").responseJSON { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(String(describing: response.result.value))")
            
        
            if let json = response.result.value as? [AnyObject]{
                    for (key,value) in json[0] as! [String:AnyObject]{
                        print(key,value)
                }
            
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook Sign In
        let loginButton = LoginButton(readPermissions: [.publicProfile ])
        loginButton.center = view.center
        
        // remove when FacebookAppID is set up
        loginButton.isUserInteractionEnabled = false

        view.addSubview(loginButton)
        
        // Google Sign In
        GIDSignIn.sharedInstance().uiDelegate = self
        let screenSize: CGRect = UIScreen.main.bounds
        let xPosition = (screenSize.width-190)/2
        let yPosition = (screenSize.height/2)+30
        btnSignIn = GIDSignInButton(frame: CGRect(x:xPosition,y:yPosition,width:190,height:48))
        
        btnSignIn.style = GIDSignInButtonStyle.standard
        btnSignIn.isUserInteractionEnabled = false
        view.addSubview(btnSignIn)
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

