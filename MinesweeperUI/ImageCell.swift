//
//  ImageCell.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 2/4/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class ImageCell : UICollectionViewCell
{

    @IBOutlet weak var myImage: UIImageView!

    
    var ic:ImageController?
    

    func singleTap(_ sender:UITapGestureRecognizer)
    {
        print("got to image cell")
        //not being initialized correctly
        ic?.selectImageFromPhotoLibrary(curCell: self)
    }
    

}
