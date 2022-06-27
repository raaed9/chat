//
//  UsersTableViewController.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 21/10/1443 AH.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    
    //MARK: - Vars
    
    var allUsers :[User] = []
    var filteredUser :[User] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
//        allUsers = [User.currentUser!]

        tableView.tableFooterView = UIView()
        downloadUsers()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        
        
        self.refreshControl = UIRefreshControl ()
        self.tableView.refreshControl = self.refreshControl
        
    }
    
    
    //MARK: - UIScrollView Delegate function
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if self.refreshControl!.isRefreshing {
            self.downloadUsers()
            self.refreshControl!.endRefreshing()
        }
    }
    
    

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return searchController.isActive ?filteredUser.count : allUsers.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UsersTableViewCell
 
        
        let user = searchController.isActive ? filteredUser[indexPath.row]: allUsers[indexPath.row]
        
        cell.configureCell(user: user)

        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "ColorTableview")
        return headerView
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = searchController.isActive ? filteredUser[indexPath.row] : allUsers[indexPath.row]
        
        showUserProfile(user)
    }
    //MARK: - Download all users from firestore
    
    private func downloadUsers () {
        FUserListener.shared.downloadAllUsersFromFirestore { firestoreAllUsers in
            
            self.allUsers = firestoreAllUsers
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
}


//MARK: - Extensions
extension UsersTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredUser = allUsers.filter({ user -> Bool in
            return user.username.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        tableView.reloadData()
    }
    
    
    //MARK: -  Naviation
    
    private func showUserProfile(_ user: User) {
        
        let profileView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileView") as! ProfileTableViewController
        
        profileView.user = user
        
        navigationController?.pushViewController(profileView, animated: true)
        
    }
    
    
}
