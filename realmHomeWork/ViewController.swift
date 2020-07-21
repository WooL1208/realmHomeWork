//
//  ViewController.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/15.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwdTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var birthDayTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var IDTextfield: UITextField!
    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var cleanBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    let picker: UIImagePickerController = UIImagePickerController()
    let addUserController = AddUserController()
    let realmEvent = RealmEvent()
    var imageData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let realm = try! Realm()
        print("fileURL: \(realm.configuration.fileURL!)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doClean(_ sender: Any) {
        accountTextfield.text = "1234"
        passwdTextfield.text = "A1234"
        nameTextfield.text = "1234"
        birthDayTextfield.text = "1234"
        emailTextfield.text = "1234@1234"
        phoneTextfield.text = "0987654321"
        IDTextfield.text = "A123456789"
    }
    
    @IBAction func doSubmit(_ sender: Any) {
        let userAccount = accountTextfield.text ?? ""
        let userPasswd = passwdTextfield.text ?? ""
        let userName = nameTextfield.text ?? ""
        let userBirthday = birthDayTextfield.text ?? ""
        let userEmail = emailTextfield.text ?? ""
        let userPhone = phoneTextfield.text ?? ""
        let userID = IDTextfield.text ?? ""
        addUserController.addAndEditData(uuid: "", img: imageData, account: userAccount, passwd: userPasswd, name: userName, birthday: userBirthday, email: userEmail, phone: userPhone, ID: userID)
        if addUserController.isPassed == false {
            alert(nowMessage: addUserController.errorCode)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doAddImg(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.allowsEditing = true // 可對照片作編輯
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let nowImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        self.showImg.image = nowImage
        imageData = nowImage!.pngData()! as Data
        print(imageData)
        picker.dismiss(animated: true, completion: nil) // 關掉

    }
        // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func alert(nowMessage:String) {
        let controller = UIAlertController(title: "輸入錯誤", message: nowMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
}

