//
//  HomeVC.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 08/12/22.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var txtUsername      : UITextField!
    @IBOutlet private weak var txtEmail         : UITextField!
    @IBOutlet private weak var txtPassword      : UITextField!
    @IBOutlet private weak var txtSubscription  : UITextField!
    
    @IBOutlet private weak var btnSave      : UIButton!
    @IBOutlet private weak var btnUpdate    : UIButton!
    @IBOutlet private weak var btnDelete    : UIButton!
    @IBOutlet private weak var btnBarRight  : UIButton!
    
    @IBOutlet private weak var imgvProfile  : UIImageView!
    
    enum HomeScreenType {
        case create
        case edit(userModel: UserModel, completion: () -> ())
    }
    
    //MARK: - Properties
    var homeScreenType = HomeScreenType.create
    
    private var userModel: UserModel?
    private var completion: (()->())?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    //MARK: - IBAction
    @IBAction private func actionSave() {
        var subscription: SubscriptionModel?
        subscription = SubscriptionModel(id             : UUID(),
                                         subscriptionId : txtSubscription.text)
        
        if let subId = subscription?.subscriptionId, subId.isEmpty {
            subscription = nil
        }
        
        let user = UserModel(username        : txtUsername.text!,
                             email           : txtEmail.text!,
                             password        : txtPassword.text!,
                             id              : UUID(),
                             profileImage    : (imgvProfile.image?.pngData())!,
                             subscription    : subscription)
        
        CDUsersDataManager.shared.create(user: user)
        
        [txtEmail,
         txtPassword,
         txtUsername,
         txtSubscription].forEach({$0?.resignFirstResponder()})
        [txtEmail,
         txtPassword,
         txtUsername,
         txtSubscription].forEach({$0?.text = ""})
        imgvProfile.image = nil
    }
    
    @IBAction private func actionUpdate() {
        let subModelId = userModel?.subscription?.id ?? UUID()
        
        var subscription: SubscriptionModel? = SubscriptionModel(
            id             : subModelId,
            subscriptionId : txtSubscription.text
        )
        
        if let subId = subscription?.subscriptionId, subId.isEmpty {
            subscription = nil
        }
        
        if CDUsersDataManager.shared.update(user: UserModel(
            username        : txtUsername.text!,
            email           : txtEmail.text!,
            password        : txtPassword.text!,
            id              : userModel!.id,
            profileImage    : (imgvProfile.image?.pngData())!,
            subscription    : subscription
        )) {
            completion?()
            pop()
        }
    }
    
    @IBAction private func actionDelete() {
        if CDUsersDataManager.shared.deleteUser(by: userModel!.id) {
            completion?()
            pop()
        }
    }
    
    @IBAction private func actionDataList() {
        let dataListVC = DataListVC.instantiateFromStoryboard(.main)!
        push(to: dataListVC)
    }
    
    @IBAction private func actionUploadImage() {
        let imagePickerController           = UIImagePickerController()
        imagePickerController.delegate      = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType    = .photoLibrary
        present(vc: imagePickerController)
    }
    
    //MARK: - Methods
    private func initialSetUp() {
        [btnSave, btnDelete, btnUpdate, btnBarRight].forEach({$0?.isHidden = true})
        switch homeScreenType {
        case .create:
            title = "Create"
            btnSave.isHidden = false
            btnBarRight.isHidden = false
            navigationController?.navigationBar.prefersLargeTitles = true
        case .edit(let userModel, let completion):
            title = "Edit"
            self.userModel = userModel
            btnUpdate.isHidden = false
            btnDelete.isHidden = false
            
            self.completion = completion
            
            txtEmail.text           = userModel.email
            txtUsername.text        = userModel.username
            txtPassword.text        = userModel.password
            txtSubscription.text    = userModel.subscription?.subscriptionId
            imgvProfile.image       = UIImage(data: userModel.profileImage)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension HomeVC : UIImagePickerControllerDelegate,
                   UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            self.imgvProfile.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
    }
}
