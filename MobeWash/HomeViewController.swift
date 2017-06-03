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
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Center based on screen size
        let xPosition = (screenSize.width-190)/2
        // FB Login button y position relative to default Login button
        var yPosition = self.loginButtonOutlet.frame.origin.y+(self.loginButtonOutlet.frame.size.height*2)+20
        
        // Facebook Login Button
        let FBloginButton = LoginButton(readPermissions: [.publicProfile ])
        FBloginButton.frame = CGRect(x:xPosition,y:yPosition,width:190,height:48)
        
        // remove when FacebookAppID is set up
        FBloginButton.isUserInteractionEnabled = false

        view.addSubview(FBloginButton)
        
        // Google Signin button relative to FB Login button
        yPosition = yPosition + FBloginButton.frame.size.height + 10
        
        // Google Sign In Button
        GIDSignIn.sharedInstance().uiDelegate = self
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

