//
//  SettingsViewController.swift
//  shiokrecipes
//
//  Created by Clarence Chan on 20/6/20.
//  Copyright © 2020 clarencechan. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func didDismissSettingsModal()
}

class SettingsViewController: UITableViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        
        self.title = "Settings"
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissScreen))
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.delegate?.didDismissSettingsModal()
    }
    
    @objc private func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source & delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                lb.font = .systemFont(ofSize: 14, weight: .medium)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(AccountSettingsViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
        case 2:
            print("Terms & Conditions tapped")
        case 3:
            print("Privacy Policy tapped")
        case 4:
            print("Acknowledgement & Credits tapped")
        case 5:
            print("App Version tapped")
        case 6:
            let alert = UIAlertController(title: "Log out", message: "Are you sure you wish to log out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { _ in
                self.showSpinner()
                AuthHelper.shared.logout() { [weak self] _ in
                    guard let self = self else { return }
                    self.removeSpinner()
                }
            }))
            alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
