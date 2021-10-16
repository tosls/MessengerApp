//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 25.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var infoAboutUserTF: UITextField!
    
    @IBOutlet var editProfileImageButton: UIButton!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveGCDButton: UIButton!
    @IBOutlet var saveButtonOperations: UIButton!
    
    @IBOutlet var saveProcessIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        userNameTF.delegate = self
        infoAboutUserTF.delegate = self
        
        userNameTF.isUserInteractionEnabled = false
        infoAboutUserTF.isUserInteractionEnabled = false
    }
 
    
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        userNameTF.isUserInteractionEnabled = true
        userNameTF.returnKeyType = UIReturnKeyType.done
        userNameTF.enablesReturnKeyAutomatically = true
        infoAboutUserTF.isUserInteractionEnabled = true
        userNameTF.becomeFirstResponder()
        
        saveGCDButton.isEnabled = false
        saveButtonOperations.isEnabled = false
        
        userNameTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        hideAButtons()
    }
    
    @IBAction func editProfileImageButtonTapped(_ sender: UIButton) {
        actionSheetController()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveGCDButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func saveOperationsButtonTapped(_ sender: UIButton) {
       
    }
   
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        userNameTF.text = ""
        infoAboutUserTF.text = ""
        setupProfileImageView()
        
        hideAButtons()
    }
    
    //MARK: Setuping a view
    
    @objc func textFieldDidChange(textField: UITextField){
        enableAButtons()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupProfileImageView()
        
        saveGCDButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        saveButtonOperations.layer.cornerRadius = 10
        
        saveProcessIndicator.isHidden = true
        
        editProfileButton.isHidden = false
        saveButtonOperations.isHidden = true
        saveGCDButton.isHidden = true
        cancelButton.isHidden = true
        editProfileImageButton.isHidden = true
    }
    
    private func hideAButtons() {
        editProfileButton.isHidden.toggle()
        cancelButton.isHidden.toggle()
        saveGCDButton.isHidden.toggle()
        saveButtonOperations.isHidden.toggle()
        editProfileImageButton.isHidden.toggle()
    }
    
    private func enableAButtons() {
        saveGCDButton.isEnabled.toggle()
        saveButtonOperations.isEnabled.toggle()
    }
 
    
    private func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.backgroundColor = UIColor(red: 0.894,
                                                   green: 0.908,
                                                   blue: 0.17,
                                                   alpha: 1)
        
        let imageViewHeight = profileImageView.bounds.height
        let imageViewWidth = profileImageView.bounds.width
        let userInitials = UserProfileModel.userNameToInitials(name: userNameTF.text ?? "User Name")
        profileImageView.image = userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
    }
    
    
    //MARK: Getting a profile picture
    
    
    private func userInitialsToImage(_ text: String, _ imageViewHeight: CGFloat, _ imageViewWidth: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContext(CGSize(width: imageViewWidth, height: imageViewHeight))
        
        let font = UIFont(name: "Helvetica", size: imageViewHeight / 2)
        let fontStyle = NSMutableParagraphStyle()
        fontStyle.alignment = NSTextAlignment.center
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.black,
                          NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: fontStyle]
        
        let textSize = text.size(withAttributes: attributes as [NSAttributedString.Key : Any])
        
        let rectangle = CGRect(x: imageViewWidth / 2 - textSize.width / 2,
                               y: imageViewHeight / 2 - textSize.height / 2 ,
                               width: textSize.width,
                               height: textSize.height)
        
        text.draw(in:rectangle, withAttributes: attributes as [NSAttributedString.Key : Any])
        
        let userInitialsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return userInitialsImage
    }
    
    private func actionSheetController() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.fetchPhotoFromCamera()
        }))
        actionSheetController.addAction(UIAlertAction(title: "Open gallery", style: .default, handler: { _ in
            self.fetchPhotoFromGallery()
        }))
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheetController, animated: true)
    }
}


    //MARK: Extension ImagePickerController


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var profileImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            profileImage = editedImage
            
            enableAButtons()

        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImage = originalImage
            
            enableAButtons()
        }
        profileImageView.image = profileImage
        
        dismiss(animated: true)
        
        guard profileImage != nil else {
            print("Not Image")
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


//MARK: Extension UITextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        }
}
