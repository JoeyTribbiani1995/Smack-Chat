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
    
    var avatarType = Avatartype.dark
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.dataSource = self
        collectView.delegate = self

    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        if segementControl.selectedSegmentIndex == 0 {
            avatarType = Avatartype.dark
        }else {
            avatarType = Avatartype.light
        }
        collectView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCollectCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        
        return AvatarCollectCell()
    }
    
    //size item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColums : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColums = 4
        }
        
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColums - 1) * spaceBetweenCells) / numberOfColums
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else {
             UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
