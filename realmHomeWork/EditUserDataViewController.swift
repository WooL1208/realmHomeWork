//
//  EditUserDataViewController.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/21.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift

class EditUserDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var showEditImg: UIImageView!
    @IBOutlet weak var editAccount: UITextField!
    @IBOutlet weak var editPasswd: UITextField!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editBirthday: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editPhone: UITextField!
    @IBOutlet weak var editID: UITextField!
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cleanBtn: UIButton!
    
    let picker: UIImagePickerController = UIImagePickerController()
    let realmEvent = RealmEvent()
    let addUserController = AddUserController()
    var imageData = Data()
    var uuid = ""
    var nowIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realmEvent.loadData()
        uuid = realmEvent.results[nowIndexPath].uuid
        let nowImage = UIImage(data: realmEvent.results[nowIndexPath].image as Data)
        showEditImg.image = nowImage
        imageData = realmEvent.results[nowIndexPath].image
        editAccount.text = realmEvent.results[nowIndexPath].account
        editPasswd.text = realmEvent.results[nowIndexPath].passwd
        editName.text = realmEvent.results[nowIndexPath].name
        editBirthday.text = realmEvent.results[nowIndexPath].birthday
        editEmail.text = realmEvent.results[nowIndexPath].email
        editPhone.text = realmEvent.results[nowIndexPath].phone
        editID.text = realmEvent.results[nowIndexPath].ID
    }
    
    @IBAction func doSave(_ sender: Any) {
        let newAccount = editAccount.text ?? ""
        let newPasswd = editPasswd.text ?? ""
        let newName = editName.text ?? ""
        let newBirthday = editBirthday.text ?? ""
        let newEmail = editEmail.text ?? ""
        let newPhone = editPhone.text ?? ""
        let newID = editID.text ?? ""
        addUserController.addAndEditData(uuid: uuid, img: imageData, account: newAccount, passwd: newPasswd, name: newName, birthday: newBirthday, email: newEmail, phone: newPhone, ID: newID)
        if addUserController.isPassed == false {
            alert(nowMessage: addUserController.errorCode)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func doClean(_ sender: Any) {
        
    }
    
    @IBAction func doEditImg(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.allowsEditing = true // 可對照片作編輯
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let nowImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
            self.showEditImg.image = nowImage
            imageData = nowImage!.pngData()! as Data
            picker.dismiss(animated: true, completion: nil) // 關掉
    }
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func alert(nowMessage:String) {
        let controller = UIAlertController(title: "編輯失敗", message: nowMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
