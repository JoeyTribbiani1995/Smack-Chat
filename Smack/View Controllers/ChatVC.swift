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
    @IBOutlet weak var typingUserLbl: UILabel!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    var isTyping = false
    
    
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
        
        SocketService.instance.getMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    
                }
            }
            
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else {
                        names = "\(names) \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            }else {
                self.typingUserLbl.text = ""
            }
        }
            
       sendMessageBtn.isHidden = true
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
                print("get messages success------------------")
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
                    
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.id)
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
    
    @IBAction func messageEditing(_ sender: UITextField) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        if messageTxt.text == "" {
            isTyping = false
            sendMessageBtn.isHidden = true
    
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name,channelId)
        }else {
            if isTyping == false {
                sendMessageBtn.isHidden = false
            }
            isTyping = true
            SocketService.instance.socket.emit("startType", UserDataService.instance.name,channelId)
        }
        
    }
    
    
}
