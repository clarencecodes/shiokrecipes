//
//  AccountSettingsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 21/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class AccountSettingsViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var firstName: String!
    private var lastName: String!
    private var email: String!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let userIdRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        userIdRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                self.firstName = (document.get("first_name") as! String)
                self.lastName = (document.get("last_name") as! String)
                self.email = Auth.auth().currentUser!.email
                
                self.tableView.reloadData()
            } else {
                print("Document does not exist")
            }
        }
        
        tableView.register(SettingsTextFieldCell.self, forCellReuseIdentifier: "SettingsTextFieldCell")

        self.title = "Account"
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAccountDetailChanges))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    // MARK: - Save changes to Firebase
    
    @objc private func saveAccountDetailChanges() {
        print("saveAccountDetailChanges")
        
        let db = Firestore.firestore()
        let userIdRef = db.collection("users").document(Auth.auth().currentUser!.uid)
        
        if let updatedFirstName = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SettingsTextFieldCell)?.textField.text,
            let updatedLastName = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SettingsTextFieldCell)?.textField.text {
            
            userIdRef.setData([
                "first_name": updatedFirstName,
                "last_name": updatedLastName
            ]) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    // MARK: - Table view data source & delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTextFieldCell", for: indexPath) as! SettingsTextFieldCell
        
        switch indexPath.row {
        case 0:
            cell.label.text = "FIRST NAME"
            cell.textField.text = self.firstName
        case 1:
            cell.label.text = "LAST NAME"
            cell.textField.text = self.lastName
        case 2:
            cell.label.text = "EMAIL"
            cell.textField.isEnabled = false
            cell.textField.textColor = .lightGray
            cell.textField.font = .systemFont(ofSize: 14, weight: .semibold)
            cell.textField.text = self.email
        default:
            break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingsTextFieldCell
        cell.textField.becomeFirstResponder()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
