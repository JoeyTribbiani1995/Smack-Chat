//
//  CreateAccountVc.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class CreateAccountVc: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeBtnPressed(_ sender: UIButton) {
       performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    @IBAction func createAccountPressed(_ sender: UIButton) {
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("logged in user !")
                    }
                })
            }
        }
        
    }
    
    @IBAction func chooseAvatarPressed(_ sender: UIButton) {
    }
    @IBAction func generateBackgroundColorPressed(_ sender: UIButton) {
    }
}
