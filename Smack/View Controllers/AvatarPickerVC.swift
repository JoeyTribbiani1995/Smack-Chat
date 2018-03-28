//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Dũng Võ on 3/28/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    

    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var segementControl: UISegmentedControl!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.dataSource = self
        collectView.delegate = self

    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCollectCell {
            cell.setupView()
            return cell
        }
        
        return AvatarCollectCell()
    }
    
    
    
    

}
