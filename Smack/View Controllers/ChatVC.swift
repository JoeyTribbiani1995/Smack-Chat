//
//  ChatVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/25/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }else {
            UserDataService.instance.logoutUser()
        }
        
    }
    
    @objc func userDataDidChange(_ notif : Notification){
         if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }else {
            channelNameLbl.text = "Please Log In"
        }
        
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel(completion: { (success) in
            if success{
                
            }
        })
    }
    
    @objc func channelSelected(_ notif : Notification){
        updateNameWithChannel()
    }
    
    func updateNameWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelName ?? ""
        
        channelNameLbl.text = "#\(channelName)"
    }
    
}
