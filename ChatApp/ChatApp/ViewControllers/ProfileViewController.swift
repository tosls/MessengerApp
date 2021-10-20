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
    
    let userProfile = UserProfile.shared.getUserProfile()
    
    private var changeUserInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        userNameTF.delegate = self
        infoAboutUserTF.delegate = self
        
        userNameTF.isUserInteractionEnabled = false
        infoAboutUserTF.isUserInteractionEnabled = false
        
        checkATextFieldChange()
    }
    
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        userNameTF.isUserInteractionEnabled = true
        userNameTF.returnKeyType = UIReturnKeyType.done
        userNameTF.enablesReturnKeyAutomatically = true
        infoAboutUserTF.isUserInteractionEnabled = true
        userNameTF.becomeFirstResponder()
        
        saveGCDButton.isEnabled = false
        saveButtonOperations.isEnabled = false

        hideAButtons()
    }
    
    @IBAction func editProfileImageButtonTapped(_ sender: UIButton) {
        actionSheetController()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveGCDButtonTapped(_ sender: UIButton) {
        saveWithGCD()
        
    }
    
    @IBAction func saveOperationsButtonTapped(_ sender: UIButton) {
        saveWithOperations()
    }

    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        cancelChanges()
    }
    
    private func getUserProfile() {
        
    }
    
    //MARK: Setuping a view
        
    private func setupView() {
        view.backgroundColor = .white
        
        userNameTF.text = userProfile.userName
        infoAboutUserTF.text = userProfile.userInfo
        
        raiseTheViewAboveTheKeyboard()
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
        let userInitials = UserProfileModel.userNameToInitials(name: userProfile.userName ?? "User Name")
        let gcdManager = GCDManager()
        
        gcdManager.loadUserImage { [weak self] image in
            if image != nil {
                self?.profileImageView.image = image
            } else {
                self?.profileImageView.image = UserProfileModel.userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
            }
        }
    }
    
    
    //MARK: Work with User Profile
    
    
    private func saveWithOperations() {
        saveProcessIndicator.isHidden = false
        saveProcessIndicator.startAnimating()
        
        let operationManager = OperationsManager()
        operationManager.saveProfile(userData: UserProfileModel(userName: userNameTF.text, userInfo: infoAboutUserTF.text)) { [weak self] in switch $0 {
            
        case .success(_):
            self?.saveProcessIndicator.isHidden = true
            self?.saveProcessIndicator.stopAnimating()
            self?.showSuccessAlert()
        case .failure(_):
            self?.showFailAlert()
        }
        }
        hideAButtons()
    }

    private func saveWithGCD() {
        saveProcessIndicator.isHidden = false
        saveProcessIndicator.startAnimating()

        let gcdManager = GCDManager()
        
        gcdManager.saveUserProfile(userData: UserProfileModel(
            userName: userNameTF.text,
            userInfo: infoAboutUserTF.text))
            { [weak self] in switch $0 {
            case .success(_):
                self?.saveProcessIndicator.isHidden = true
                self?.saveProcessIndicator.stopAnimating()
                self?.showSuccessAlert()
            case .failure(_):
                self?.showFailAlert()
            }
            }
        hideAButtons()
    }
    
    private func cancelChanges() {
        userNameTF.text = userProfile.userName
        infoAboutUserTF.text = userProfile.userInfo
        setupProfileImageView()
        
        hideAButtons()
    }
    
    //MARK: Alerts
    
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Успешно!", message: "Данные сохранены.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showFailAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить", style: UIAlertAction.Style.default, handler: {[weak self] _ in self?.saveWithGCD()}))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { [weak self] _ in self?.cancelChanges()}))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Getting a profile picture
        
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
        UserProfileImageManager.saveUserImage(userImage: profileImage!)
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    private func checkATextFieldChange() {
        let textFields = [userNameTF, infoAboutUserTF]
        
        for textField in textFields {
            if changeUserInfo == false {
                
                textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if changeUserInfo == false {
            enableAButtons()
            changeUserInfo = true
        }
    }
    
    private func raiseTheViewAboveTheKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
