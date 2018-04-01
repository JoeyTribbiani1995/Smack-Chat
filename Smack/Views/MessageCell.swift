//
//  MessageCell.swift
//  Smack
//
//  Created by Joey Tribbiani on 4/1/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImageView: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupView(with message : Message){
        userNameLbl.text = message.userName
        userImageView.image = UIImage(named : message.userAvatar)
        userImageView.backgroundColor = UserDataService.instance.returnColor(components: message.userAvatarColor)
      //  updateTimeView(date: message.timeStamp)
        messageLbl.text = message.message
    }
    
    func updateTimeView(date : String){
        let dataForMatter = DateFormatter()
        dataForMatter.timeStyle = .short
       // timeStampLbl.text = dataForMatter.string(from:date)
    }

}
