//
//  SettingTableViewController.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 17/10/1443 AH.
//

import UIKit

class SettingTableViewController: UITableViewController {

        //MARK: - IBOutlets
    
    
    @IBOutlet weak var avatarImageOutlet: UIImageView!
    
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    
    @IBOutlet weak var statusLabelOutlet: UILabel!
   
    @IBOutlet weak var appVersionLabelOutlet: UILabel!
    
    
    //MARK: - Lifecycle of table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showUserInfo()
        
    }

    
    
    //MARK: - IB Action

    
    @IBAction func tellFriendButtonPressed(_ sender: UIButton) {
        print("tell a friend")
    }

    @IBAction func termsButtonPressed(_ sender: UIButton) {
        print("terms and conditions")
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        FUserListener.shared.logoutCurrentUser { error in
            if error == nil {
                let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginView")
                
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    

    
    
    //MARK: - Tableview Delegates
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "colorTableview")
        
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 10.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 && indexPath.row == 0 {

            performSegue(withIdentifier: "SettingsToEditProfileSegue", sender: self)

        }
    }
    
    
    
    
    //MARK: - Update UI
    
    private func showUserInfo() {
        if let user = User.currentUser {
            
            usernameLabelOutlet.text = user.username
            statusLabelOutlet.text = user.status
            
            appVersionLabelOutlet.text = "App Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
            
            
            if user.avatarLink != "" {
                //TODO: - Download and set avatar image
                FileStorage.downloadImage(imageUrl: user.avatarLink) { avatarImage in
                    self.avatarImageOutlet.image = avatarImage?.circleMasked
                }
            }
            
        }
        
    }
}
