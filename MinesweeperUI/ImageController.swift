//
//  ImageController.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 2/5/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class ImageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageCell
        
        cell.myImage.image = #imageLiteral(resourceName: "unknown")
        
        print("registered")
        let tap1 = UITapGestureRecognizer(target: cell, action: #selector(ImageCell.singleTap(_:)))
        tap1.numberOfTapsRequired = 1
        cell.addGestureRecognizer(tap1)
        
        return cell
    }
    
    func selectImageFromPhotoLibrary(curCell:ImageCell) {
        
        print("got here")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated:true, completion:nil)
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            // The info dictionary may contain multiple representations of the image. You want to use the original.
            guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            
            // Set photoImageView to display the selected image.
            curCell.myImage.image = selectedImage
            
            dismiss(animated: true, completion: nil)
        }

        

    }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // Dismiss the picker if the user canceled.
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//                
//        // The info dictionary may contain multiple representations of the image. You want to use the original.
//        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//        
//        // Set photoImageView to display the selected image.
//        
//        dismiss(animated: true, completion: nil)
//    }


}
