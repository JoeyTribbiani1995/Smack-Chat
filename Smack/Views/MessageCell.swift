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
        messageLbl.text = message.message
        
        //2017-07-13T21:49:25.590Z
        guard var isoDate = message.timeStamp else { return }
        
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        //2017-07-13T21:49:25
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from : isoDate.appending("Z"))
        //2017-07-13T21:49:25Z
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d , h:mm a"
        
        if let finalDate = chatDate {
            let getDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = getDate
        }
        
    }
}
