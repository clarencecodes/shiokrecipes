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
        
        self.email = Auth.auth().currentUser!.email
        if let fullNameArr = Auth.auth().currentUser?.displayName?.components(separatedBy: " ") {
            self.firstName = fullNameArr[0]
            self.lastName = fullNameArr[1]
            self.tableView.reloadData()
        }
                
        tableView.register(SettingsTextFieldCell.self, forCellReuseIdentifier: "SettingsTextFieldCell")

        self.title = "Account"
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAccountDetailChanges))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Save changes to Firebase
    
    @objc private func saveAccountDetailChanges() {
        print("saveAccountDetailChanges")
        
        guard let updatedFirstName = (tableView.visibleCells[0] as? SettingsTextFieldCell)?.textField.text,
            let updatedLastName = (tableView.visibleCells[1] as? SettingsTextFieldCell)?.textField.text,
            !updatedFirstName.isEmpty,
            !updatedLastName.isEmpty else {
                self.showAlert(message: Constants.Strings.ensureAllFieldsFilled)
                return
        }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        let displayName = "\(updatedFirstName) \(updatedLastName)"
            changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in
            if let error = error {
                print("Error updating user's display name: \(error)")
            } else {
                print("Updated user's name to \(displayName)")
                self.dismiss(animated: true, completion: nil)
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
        cell.textField.delegate = self
        
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

// MARK: - UITextFieldDelegate
extension AccountSettingsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Do not allow user to type in a whitespace when editing firstName or lastName
        
        if string == " " {
            return false
        }
        return true
    }
}
