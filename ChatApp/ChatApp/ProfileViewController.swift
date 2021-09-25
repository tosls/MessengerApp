//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 25.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileInfoLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProfileImageView()
        setupSaveButton()
        
        profileInfoLabel.text = "UX/UI designer, web-designer Moscow, Russia"
    }
    
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        actionSheetController()
    }
    //MARK: Setup View
    
    private func setupNavigationBar() {
        navigationItem.title = "My Profile"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
       
    }
    
    private func setupProfileImageView() {
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.backgroundColor = UIColor(red: 0.894, green: 0.908, blue: 0.17, alpha: 1)
    }
    
    private func setupSaveButton() {
        saveButton.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        saveButton.layer.cornerRadius = 14
    }
    
    //MARK: Take Profile Image
    
    private func actionSheetController() {
        let actionSheetController = UIAlertController(title: "Test", message: "TestOne", preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Take Foto", style: .default, handler: { _ in
            self.fetchPhotoFromCamera()
        }))
        actionSheetController.addAction(UIAlertAction(title: "Open Gallery", style: .default, handler: { _ in
            self.fetchPhotoFromGallery()
        }))
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var profileImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            profileImage  = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImage = originalImage
        }
        profileImageView.image = profileImage
        dismiss(animated: true)
        
        guard profileImage != nil else {
            print("not Image")
            return
        }
    }
    
    private func fetchPhotoFromGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func fetchPhotoFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
}
