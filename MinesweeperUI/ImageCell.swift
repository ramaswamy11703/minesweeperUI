//
//  ImageCell.swift
//  MinesweeperUI
//
//  Created by Shekar Ramaswamy on 2/4/17.
//  Copyright © 2017 Shekar Ramaswamy. All rights reserved.
//

import UIKit

class ImageCell : UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    
    @IBOutlet weak var myImage: UIImageView!
    var ic:ImageController?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func singleTap(_ sender:UITapGestureRecognizer)
    {
        self.selectImageFromPhotoLibrary(sender)
    }
    
    
    func selectImageFromPhotoLibrary(_ sender:UITapGestureRecognizer)
    {
        let imagePickerController = UIImagePickerController()
        // let navigationController = UINavigationController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        // navigationController.delegate = self
        ic?.present(imagePickerController, animated:true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        myImage.image = selectedImage
        ic?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        ic?.dismiss(animated: true, completion: nil)
    }
}
