//
//  HomeViewController.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 1/30/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named:"home.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    @IBAction func levelCode(_ sender: Any) {
        self.performSegue(withIdentifier: "homeToImage", sender: self)
    }
    
     
}
