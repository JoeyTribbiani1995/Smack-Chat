//
//  ChannelCell.swift
//  Smack
//
//  Created by Dũng Võ on 3/29/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.1).cgColor
        }else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell( channel : Channel ){
        let title = channel.channelName ?? ""
        
        channelName.text = "#\(title)"
        
        channelName.font = UIFont(name : "HelveticaNeue-Regular",size : 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
        
    }
}
