//
//  LoginVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func creatAccountBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
   
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        activity.isHidden = false
        activity.startAnimating()
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                print("logged in successed !")
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        print("find email success !")
                        NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE ,object : nil)
                        self.activity.isHidden = true
                        self.activity.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setupView(){
        activity.isHidden = true
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string :"email" ,attributes:[NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string :"password" ,attributes:[NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        //fix can't touch when create user
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
