//
//  ProfileVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/28/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bgColor: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeModelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        UserDataService.instance.logoutUser()
        
        NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE,object : nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        nameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        profileImage.image = UIImage(named : UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnColor(components: UserDataService.instance.avatarColor)
        
        let closetouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgColor.addGestureRecognizer(closetouch)
    }
    
    @objc func closeTap(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
}
