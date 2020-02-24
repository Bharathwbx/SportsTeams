//
//  CreateTeamController+UIImagePicker.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

extension CreateTeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            teamImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            teamImageView.image = originalImage
        }
        setUpCircularImageStyle()
        dismiss(animated: true, completion: nil)
    }

    
}
