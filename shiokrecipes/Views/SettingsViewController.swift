//
//  SettingsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 20/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        self.title = "Settings"
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissScreen))
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        switch indexPath.row {
        case 0:
            cell.label.text = "Account"
        case 1:
            cell.label.text = "Change Password"
        case 2:
            cell.label.text = "Terms & Conditions"
        case 3:
            cell.label.text = "Privacy Policy"
        case 4:
            cell.label.text = "Acknowledgement & Credits"
        case 5:
            cell.label.text = "App Version"
            cell.rightChevron.isHidden = true
            
            let versionLabel: UILabel = {
                let lb = UILabel()
                lb.translatesAutoresizingMaskIntoConstraints = false
                lb.font = .systemFont(ofSize: 14)
                lb.textColor = .lightGray
                lb.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                return lb
            }()
            
            cell.contentView.addSubview(versionLabel)
            
            NSLayoutConstraint.activate([
                versionLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                versionLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20)
            ])
        case 6:
            cell.label.text = "Log out"
            cell.label.textColor = Constants.Design.Color.orange
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
