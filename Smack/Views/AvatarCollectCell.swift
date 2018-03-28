//
//  AvatarCollectCell.swift
//  Smack
//
//  Created by Dũng Võ on 3/28/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

enum Avatartype {
    case dark
    case light
}

class AvatarCollectCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func configureCell( index : Int , type : Avatartype){
        if type == Avatartype.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.darkGray.cgColor
        }
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
