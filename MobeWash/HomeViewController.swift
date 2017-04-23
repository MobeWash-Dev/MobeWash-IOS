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

class HomeViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    var btnSignIn : GIDSignInButton!

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        
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
=======
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("For testing purpose only.")
>>>>>>> development
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

