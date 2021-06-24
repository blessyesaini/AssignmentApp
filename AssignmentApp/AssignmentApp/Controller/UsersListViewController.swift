//
//  UsersListViewController.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import UIKit
import SVProgressHUD
import Reachability
class UsersListViewController: UIViewController {
    
    @IBOutlet weak var networkStatusSegment: UISegmentedControl!
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var usersTableView: UITableView!
    
    var isOffline: Bool = true
    var offlineDatas: [Any] = []
    var onlineDatas: UserActivitiesResponse = []
    
    //MARK: - View Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initProcess()
    }
    //MARK: - init method to set the values inititally

    fileprivate func initProcess() {
        usersTableView.register(UINib(nibName: AppCells.userTableviewCell.getName(), bundle: nil), forCellReuseIdentifier: AppCells.userTableviewCell.getName())
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.tableHeaderView = UIView()
        usersTableView.tableFooterView = UIView()
        getOfflineDatas()
        
    }
    
    //MARK: - method to get data from database

    func getOfflineDatas() {
        
        DatabaseHandler.shared.retrieveData { userRecords in
            self.offlineDatas = userRecords
            self.usersTableView.reloadData()
        }
    }
    //MARK: - method to get data from API service

    func getOnlineDatas() {
        
        if GeneralHandler().testConnection() {
       
        let request = UserActivitiesRequest()
        
        SVProgressHUD.show()
        
        SessionHandlers.sessionHandler(url: request.getURL(), parameters: request.getParams(enquries: nil), method: .get) { response in
            
            DispatchQueue.main.async {
                
                SVProgressHUD.dismiss()
                
                if response.status {
                    
                    guard let responseData = response.response as? Data else {
                        return
                    }
                    let userActivities = try? JSONDecoder().decode(UserActivitiesResponse.self, from: responseData)
                    
                    self.onlineDatas = userActivities ?? []
                    
                    self.usersTableView.reloadData()
                    
                }
            }
            
            
        }
     }
      
    }
    
    //MARK: - on select of segmentcontrol

    @IBAction func onChangeNetworkMode(_ sender: UISegmentedControl) {
        isOffline = sender.selectedSegmentIndex == 0 ? true : false
        
        self.onlineDatas.removeAll()
        self.offlineDatas.removeAll()
        
        usersTableView.reloadData()
        
        if isOffline {
            getOfflineDatas()
        } else {
            
            getOnlineDatas()
        }
        
    }
    //MARK: - show no data view when data is empty

    func manageTableViewEmptyData(tableView: UITableView) {
        
        if isOffline, offlineDatas.count == 0 {
            tableView.backgroundView = noDataView
        } else if !isOffline,onlineDatas.count == 0 {
            tableView.backgroundView = noDataView
        } else{
            tableView.backgroundView = nil
        }
        
    }
}
//MARK: - Tableview delegate and datasourcemethods

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.manageTableViewEmptyData(tableView: tableView)
      return  isOffline ? offlineDatas.count : onlineDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppCells.userTableviewCell.getName(), for: indexPath) as! UserTableViewCell
        cell.loadDatas(isOffline: isOffline, offlineData: isOffline ? offlineDatas[indexPath.row] : onlineDatas[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
