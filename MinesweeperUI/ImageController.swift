//
//  ImageController.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 2/5/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class ImageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    let reuseIdentifier = "imageCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageCell
        
        cell.myImage.image = #imageLiteral(resourceName: "unknown")
        
        return cell
    }

}
