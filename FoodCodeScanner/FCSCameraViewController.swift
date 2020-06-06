//
//  FCSCameraViewController.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 5/9/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import UIKit

class FCSCameraViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func makePhotoButtonPressed(_ sender: Any) {
        createAndPresentImageController()
    }
    
    private func createAndPresentImageController() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return createAndPresentAlert() }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func createAndPresentAlert() {
        let alertVC = UIAlertController(title: "Camera is not available on your device",
                                        message: nil,
                                        preferredStyle: .alert)
        let cencel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(cencel)
        present(alertVC, animated: true, completion: nil)
    }
}

extension FCSCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
