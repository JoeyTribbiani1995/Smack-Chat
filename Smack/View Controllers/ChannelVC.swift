//
//  ChannelVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/25/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //width show
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
