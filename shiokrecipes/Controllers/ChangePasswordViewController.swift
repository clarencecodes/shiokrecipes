//
//  ChangePasswordViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 21/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PasswordTextFieldCell.self, forCellReuseIdentifier: "PasswordTextFieldCell")

        self.title = "Change Password"
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveNewPasswordChanges))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func saveNewPasswordChanges() {
        print("saveNewPasswordChanges")
        guard let currentPassword = (tableView.visibleCells[0] as? PasswordTextFieldCell)?.secureTextField.text,
            let newPassword = (tableView.visibleCells[1] as? PasswordTextFieldCell)?.secureTextField.text,
            let confirmPassword = (tableView.visibleCells[2] as? PasswordTextFieldCell)?.secureTextField.text,
            !currentPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
                self.showAlert(title: Constants.Strings.oopsAlertTitle, message: Constants.Strings.ensureAllFieldsFilled)
                return
        }
        
        if newPassword != confirmPassword {
            self.showAlert(title: Constants.Strings.oopsAlertTitle, message: Constants.Strings.confirmPasswordMustMatchPassword)
        } else {
            guard let email = Auth.auth().currentUser?.email else { return }
            
            self.showSpinner()
            
            // Check if user's current password is correct before changing the password
            Auth.auth().signIn(withEmail: email, password: newPassword) { authResult, error in
                self.hideSpinner()
                if let error = error {
                    self.showAlert(title: Constants.Strings.oopsAlertTitle, message: error.localizedDescription)
                } else {
                    // Current password is correct. Proceeding with password change.
                    Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                        if let error = error {
                            self.showAlert(title: Constants.Strings.oopsAlertTitle, message: error.localizedDescription)
                        } else {
                            let alert = UIAlertController(title: "Success", message: "Your password has been successfully updated.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                                guard let self = self else { return }
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordTextFieldCell", for: indexPath) as! PasswordTextFieldCell
        
        switch indexPath.section {
        case 0:
            cell.label.text = "CURRENT PASSWORD"
        case 1:
            switch indexPath.row {
            case 0:
                cell.label.text = "NEW PASSWORD"
            case 1:
                cell.label.text = "CONFIRM PASSWORD"
            default:
                break
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PasswordTextFieldCell
        cell.secureTextField.becomeFirstResponder()
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
