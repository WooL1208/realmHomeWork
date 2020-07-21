//
//  User.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/15.
//  Copyright © 2020 WooL. All rights reserved.
//

import Foundation
import RealmSwift

class users : Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var image = Data()
    @objc dynamic var account = ""
    @objc dynamic var passwd = ""
    @objc dynamic var name = ""
    @objc dynamic var birthday = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var ID = ""
    @objc dynamic var date = Date()
    override static func primaryKey() -> String? {
        return "id"
    }
}

class RealmEvent {
    let realm = try! Realm()
    var results:[(uuid:String, image:Data, account:String, passwd:String, name:String, birthday: String, email:String, phone:String, ID:String, date:Date)] = []
    func loadData() {
        let allData = realm.objects(users.self).sorted(byKeyPath: "date", ascending: false)
        for nowData in allData {
            results.append((uuid:nowData.id, image:nowData.image, account:nowData.account, passwd:nowData.passwd, name:nowData.name, birthday:nowData.birthday, email:nowData.email, phone:nowData.phone, ID:nowData.ID, date:nowData.date))
        }
    }
}
