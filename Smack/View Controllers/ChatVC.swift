//
//  ChatVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/25/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ChatVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //up to keyboard import from view keyboard bound view
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    @objc func userDataDidChange(_ notif : Notification){
         if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }else {
            channelNameLbl.text = "Please Log In"
        }
        tableView.reloadData()
        
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel(completion: { (success) in
            if success{
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateNameWithChannel()
                }else {
                    self.channelNameLbl.text = "No channels yet !"
                }
            }
        })
    }
    
    func getMessages(){
        guard  let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        MessageService.instance.getAllMessageByChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
                print("get messages success")
            }
        }
    }
    
    @objc func channelSelected(_ notif : Notification){
        updateNameWithChannel()
    }
    
    func updateNameWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelName ?? ""
        
        channelNameLbl.text = "#\(channelName)"
        
        getMessages()
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let mess = messageTxt.text else { return }
        
            SocketService.instance.addMessage(messageBody: mess, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder() // return before 
                }
            })
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            
            cell.setupView(with: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    
}
