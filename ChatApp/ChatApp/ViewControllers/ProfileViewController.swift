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
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    private var userName = UserProfile().userName
    private var userInfo = UserProfile().userInfo
    private var userInitials = UserProfile().userInitials
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        printButtonFrame() - печать Frame не возможна т.к.view еще не создана и его(frame) еще не существует
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
//        printButtonFrame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        printButtonFrame()
        //Значение Frame здесь отличаются от значения во viewDidLoad, так как размеры view становятся окончательно актульны только сейчас, при вызове viewDidAppear, когда выводятся на экран. До этого они не находтся в системе отображений
    }
    
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        actionSheetController()
    }
    
    private func printButtonFrame() {
        let buttonFrame = saveButton.frame
        print(buttonFrame)
    }
    
    
    //MARK: Setuping a view
    
    
    private func setupView() {
        view.backgroundColor = .white
        
        userInfoLabel.text = userInfo
        userInfoLabel.textAlignment = .center
        userInfoLabel.textColor = .black
        userNameLabel.text = userName
        userNameLabel.textColor = .black
        
        setupSaveButton()
        setupProfileImageView()
    }
    
    private func setupSaveButton() {
        saveButton.backgroundColor = UIColor(red: 0.965,
                                             green: 0.965,
                                             blue: 0.965,
                                             alpha: 1)
        saveButton.layer.cornerRadius = 14
    }
    
    private func setupProfileImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.backgroundColor = UIColor(red: 0.894,
                                                   green: 0.908,
                                                   blue: 0.17,
                                                   alpha: 1)
        
        let imageViewHeight = profileImageView.bounds.height
        let imageViewWidth = profileImageView.bounds.width
        
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
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImage = originalImage
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
