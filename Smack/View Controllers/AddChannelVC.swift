//
//  AddChannelVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/29/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    @IBOutlet weak var nameChannelTxt: UITextField!
    @IBOutlet weak var descriptionChannelTxt: UITextField!
    @IBOutlet weak var bgColor: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func createChannelBtnPressed(_ sender: UIButton) {
        guard  let nameChannel = nameChannelTxt.text , nameChannelTxt.text != "" else {return}
        guard  let descriptionChannel = descriptionChannelTxt.text , descriptionChannelTxt.text != "" else {return}
        
        SocketService.instance.addChannel(channelName: nameChannel, channelDescription: descriptionChannel) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        
        nameChannelTxt.attributedPlaceholder = NSAttributedString(string : "Name Channel", attributes : [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        descriptionChannelTxt.attributedPlaceholder = NSAttributedString(string : "Description Channel", attributes : [NSAttributedStringKey.foregroundColor:smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.handleTap(_:)))
        bgColor.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ recog : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
