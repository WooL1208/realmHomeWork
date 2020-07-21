//
//  StartViewController.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/20.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {
    @IBOutlet weak var signInAccount: UITextField!
    @IBOutlet weak var signInPasswd: UITextField!
    @IBOutlet weak var doSignIn: UIButton!
    @IBOutlet weak var doSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func goSignIn(_ sender: Any) {
        let realm = try! Realm()
        let user = realm.objects(users.self).filter(String(format:"account='%@'",signInAccount.text!)).first
        if user != nil {
            if user?.passwd == signInPasswd.text {
                signInAccount.text = ""
                signInPasswd.text = ""
                performSegue(withIdentifier: "userDataSegue", sender: nil)
            } else {
                alert(nowMessage: "密碼錯誤")
            }
        } else {
            alert(nowMessage: "未知的帳號")
        }
    }
    
    func alert(nowMessage:String) {
        let controller = UIAlertController(title: "登入失敗", message: nowMessage, preferredStyle: .alert)
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
