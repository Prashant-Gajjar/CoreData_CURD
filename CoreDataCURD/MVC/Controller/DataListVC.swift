//
//  DataListVC.swift
//  CoreDataCURD
//
//  Created by Prashant Gajjar on 10/12/22.
//

import UIKit

class DataListVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet private weak var tblDataList: UITableView!
    
    //MARK: - Properties    
    var users: [UserModel] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    //MARK: - Methods
    private func initialSetUp() {
        title = "Data List"
        navigationController?.navigationBar.prefersLargeTitles = false
        tblDataList.delegate    = self
        tblDataList.dataSource  = self
        
        tblDataList.register(UINib(nibName: "DataTblViewCell", bundle: nil), forCellReuseIdentifier: "DataTblViewCell")
        
        reloadData()
    }
    
    private func reloadData(isTableViewReload: Bool = true) {
        if let users = CDUsersDataManager.shared.fetchAllUser() {
            self.users = users
        }
                
        if isTableViewReload {
            tblDataList.reloadData()
            tblDataList.layoutIfNeeded()
        }
    }
}

//MARK: - TableView Delegate & DataSource
extension DataListVC: UITableViewDelegate,
                      UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTblViewCell", for: indexPath) as! DataTblViewCell
        cell.setUpCellWith(obj: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.isSelected = false
                
                let homeVC = HomeVC.instantiateFromStoryboard(.main)!
                homeVC.homeScreenType = .edit(userModel: self.users[indexPath.row], completion: {
                    self.reloadData()
                })
                self.push(to: homeVC)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if CDUsersDataManager.shared.deleteUser(by: users[indexPath.row].id) {
                reloadData(isTableViewReload: false)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
