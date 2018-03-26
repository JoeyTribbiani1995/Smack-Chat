//
//  CreateAccountVc.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class CreateAccountVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeBtnPressed(_ sender: UIButton) {
       performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
}
