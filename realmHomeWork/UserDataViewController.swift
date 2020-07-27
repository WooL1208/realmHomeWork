//
//  UserDataViewController.swift
//  realmHomeWork
//
//  Created by WooL on 2020/7/20.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift

class UserDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var accountListTableView: UITableView!
    
    let realmEvent = RealmEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmEvent.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        realmEvent.loadData()
        accountListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmEvent.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel?.text = realmEvent.results[indexPath.row].account
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 刪除
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.realmEvent.deleteData(self.realmEvent.results[indexPath.row].uuid)
            self.realmEvent.loadData()
            self.accountListTableView.reloadData()
        }
        // 編輯
        let editItem = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, boolValue) in
            self.performSegue(withIdentifier: "editDataSegue", sender: indexPath.row)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        return swipeActions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDataSegue" {
            if let indexPath = segue.destination as? EditUserDataViewController {
                indexPath.nowIndexPath = sender as? Int ?? 0
            }
        }
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
