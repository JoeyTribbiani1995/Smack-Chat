//
//  CustomBtn.swift
//  Smack
//
//  Created by Dũng Võ on 3/27/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

@IBDesignable
class CustomBtn: UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 3.0{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
