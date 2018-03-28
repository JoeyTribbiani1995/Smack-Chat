//
//  AvatarCollectCell.swift
//  Smack
//
//  Created by Dũng Võ on 3/28/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class AvatarCollectCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
