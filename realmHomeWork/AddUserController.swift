//
//  AddUserController.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/15.
//  Copyright © 2020 WooL. All rights reserved.
//

import Foundation
import RealmSwift

class AddUserController {
    var isPassed = false
    var errorCode = ""
    func addAndEditData(uuid:String, img:Data, account: String, passwd: String, name: String, birthday: String, email: String, phone: String, ID: String){
        //確認資料內容
        errorCode = ""
        isPassed = false
        if img.count > 16777216 {
            errorCode += "相片過大\n"
        }
        if img.count == 0 {
            errorCode += "未選擇相片\n"
        }
        if account == "" || account != regularExpression(regex: "[[a-zA-Z0-9]]{4,10}", validateString: account) {
            errorCode += "帳號格式錯誤\n"
        }
        if account == "" || passwd != regularExpression(regex: "[A-Z]\\w{4,9}", validateString: passwd) {
            errorCode += "密碼格式錯誤\n"
        }
        if name == "" {
            errorCode += "未填寫名字\n"
        }
        if birthday == "" {
            errorCode += "未填寫生日\n"
        }
        if email == "" || email != regularExpression(regex: ".+@.+", validateString: email) {
            errorCode += "email格式錯誤\n"
        }
        if phone == "" || phone != regularExpression(regex: "09[0-9]{8}", validateString: phone) {
            errorCode += "手機號碼格式錯誤\n"
        }
        if !checkID(source: ID) {
            errorCode += "身分證字號格式錯誤\n"
        }
        if errorCode == "" {
           isPassed = true
            print("OK")
        } else {
            isPassed = false
            print(errorCode)
            print("not OK")
        }
        
        // 加入資料庫
        if isPassed == true {
            let realm = try! Realm()
            let user = users()
            if uuid == "" {
                user.image = img
                user.account = account
                user.passwd = passwd
                user.name = name
                user.birthday = birthday
                user.email = email
                user.phone = phone
                user.ID = ID
                try! realm.write {
                    realm.add(user)
                }
            } else {
                user.id = uuid
                user.image = img
                user.account = account
                user.passwd = passwd
                user.name = name
                user.birthday = birthday
                user.email = email
                user.phone = phone
                user.ID = ID
                try! realm.write {
                    realm.add(user, update: .all)
                }
            }
            
        }
    }
    
    func checkID(source: String) -> Bool {
       /// 轉成小寫字母
       let lowercaseSource = source.lowercased()
       
       /// 檢查格式，是否符合 開頭是英文字母＋後面9個數字
       func validateFormat(str: String) -> Bool {
           let regex: String = "^[a-z]{1}[1-2]{1}[0-9]{8}$"
           let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
           return predicate.evaluate(with: str)
       }
       
       if validateFormat(str: lowercaseSource) {
           
           /// 判斷是不是真的，規則在這邊(http://web.htps.tn.edu.tw/cen/other/files/pp/)
           let cityAlphabets: [String: Int] =
               ["a":10,"b":11,"c":12,"d":13,"e":14,"f":15,"g":16,"h":17,"i":34,"j":18,
                "k":19,"l":20,"m":21,"n":22,"o":35,"p":23,"q":24,"r":25,"s":26,"t":27,
                "u":28,"v":29,"w":30,"x":31,"y":32,"z":33]

           /// 把 [Character] 轉換成 [Int] 型態
           let ints = lowercaseSource.compactMap{ Int(String($0)) }

           /// 拿取身分證第一位英文字母所對應當前城市的
           guard let key = lowercaseSource.first,
               let cityNumber = cityAlphabets[String(key)] else {
               return false
           }
    
           /// 經過公式計算出來的總和
           let firstNumberConvert = (cityNumber / 10) + ((cityNumber % 10) * 9)
           let section1 = (ints[0] * 8) + (ints[1] * 7) + (ints[2] * 6)
           let section2 = (ints[3] * 5) + (ints[4] * 4) + (ints[5] * 3)
           let section3 = (ints[6] * 2) + (ints[7] * 1) + (ints[8] * 1)
           let total = firstNumberConvert + section1 + section2 + section3

           /// 總和如果除以10是正確的那就是真的
           if total % 10 == 0 { return true }
       }
        return false
    }
    
    /// 正則匹配
    ///
    /// - Parameters:
    /// - regex: 匹配規則
    /// - validateString: 匹配對test象
    /// - Returns: 返回結果
    func regularExpression (regex:String,validateString:String) -> String{
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
            let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
            var data:String = ""
            for item in matches {
                let string = (validateString as NSString).substring(with: item.range)
                data += string
            }
            return data
        }
        catch {
            return ""
        }
    }
}
