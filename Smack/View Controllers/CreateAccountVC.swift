//
//  CreateAccountVc.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
        
            //change value avatar to create a user below
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("ligt") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func closeBtnPressed(_ sender: UIButton) {
       performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    @IBAction func createAccountPressed(_ sender: UIButton) {
        activity.isHidden = false
        activity.stopAnimating()
        
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("token",AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (succes) in
                            if success {
                                self.activity.isHidden = true
                                self.activity.stopAnimating()
                                print("user",UserDataService.instance.name,UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                
                                NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE , object : nil)
                            }
                        })
                    }
                })
                
            }
        }
        
    }
    
    @IBAction func chooseAvatarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func generateBackgroundColorPressed(_ sender: UIButton) {
        let red = CGFloat(arc4random_uniform(255))/255
        let green = CGFloat(arc4random_uniform(255))/255
        let blue = CGFloat(arc4random_uniform(255))/255
        
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }
        
        
         //change value avatar to create a user
        
    }
    
    func setupView(){
        activity.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string :"ussername" ,attributes:[NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string :"email" ,attributes:[NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string :"password" ,attributes:[NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        //fix can't touch when create user
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
   @objc func handleTap(){
        view.endEditing(true)
    }
    
    
}
