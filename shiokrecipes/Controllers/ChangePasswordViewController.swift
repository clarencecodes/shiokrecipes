//
//  ChangePasswordViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 21/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

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
        self.dismiss(animated: true, completion: nil)
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
