//
//  MyCollectionViewCell.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 1/22/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myLabel: UILabel!
     
    @IBOutlet weak var myImage: UIImageView!
     
    var row:Int = 0
    var col:Int = 0
    var vc:ViewController?
    
    func singleTap(_ sender:UITapGestureRecognizer)
    {
        vc?.singleTap(row: row, col: col)
    }
    
    func doubleTap(_ sender:UITapGestureRecognizer)
    {
        vc?.doubleTap(row: row, col: col)
    }
}
