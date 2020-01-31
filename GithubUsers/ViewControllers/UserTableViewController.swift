//
//  UserTableViewController.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/27/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import UIKit
import Toast_Swift
class UserTableViewController: UITableViewController,UserTableViewCellDelegate,EmptyViewDelegate {
    
    //constants
    let CELL_IDENTIFIER = "USER_CELL"
    let USER_CELL_NIB_NAME = "UserTableViewCell"
    let EMPTY_VIEW_NIB_NAME = "TableViewBackgroundView"
    let WEB_VIEW_SEGUE = "goToWebView"
    
    var currentPage = 1 // for api call
    let USER_PER_PAGE = 10
    
    
    var userViewModelList = [UserViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigation()
        self.fetchData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModelList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var userCell = UserTableViewCell()
        if let cell  = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER) as? UserTableViewCell{
            let user = userViewModelList[indexPath.row]
            cell.setData(user: user)
            cell.delegate = self
            userCell = cell
        }
        return userCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: WEB_VIEW_SEGUE, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case WEB_VIEW_SEGUE :
            if let controller = segue.destination as? WebViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    controller.githubUrl = userViewModelList[indexPath.row].getGithubUrl()
                }
                
            }
        default :
            break
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == userViewModelList.count - 1  {
            self.tableView.tableFooterView?.isHidden = false
            self.currentPage+=1
            self.fetchData()
        }
    }
    
    //setting up necessary views
    func setUpTableView(){
        tableView.register(UINib(nibName: USER_CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER)
        prepareFooterView()
        prepareEmptyView(STATUS.loading)
    }
    
    func setUpNavigation() {
        self.title = "Github Users"
    }
    // end of setting views
    
    //prepare custom view into UI
    func prepareFooterView(){
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(50))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func prepareEmptyView(_ status : STATUS) {
        if let emptyView = UINib(nibName: EMPTY_VIEW_NIB_NAME, bundle: nil).instantiate(withOwner: nil, options: nil).first as? EmptyView{
            if userViewModelList.count > 0 {
                self.tableView.backgroundView = nil
            }else{
                emptyView.setData(status: status)
                emptyView.delegate = self
                self.tableView.backgroundView = emptyView
            }
            
        }
    }
    //end of prepare
    
    //reload Tableview after fetching data
    func reloadTableView(_ status : STATUS){
        self.prepareEmptyView(status)
        self.tableView.reloadData()
    }
    
    //reload Tableview after network failure
    func resetTableView() {
        currentPage = 1
        userViewModelList.removeAll()
        fetchData()
    }
    
    //fetch Data from network
    func fetchData(){
        UserDM().fetchUserPerPage(page: currentPage, per_page: USER_PER_PAGE, completionHandler: {
            result,response in
            if result {
                self.tableView.tableFooterView?.isHidden = true
                self.userViewModelList.append(contentsOf: response)
                
                if self.userViewModelList.count == 0 {
                    self.reloadTableView(STATUS.blank)
                }
                self.tableView.reloadData()
            }else{
                self.reloadTableView(STATUS.failure)
            }
        })
    }
    
    //delegate from user tableview cell to handle click fav action
    func didChangeFav(_ sender: UserTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender){
            userViewModelList[indexPath.row].setFav()
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    //delegate from user tableview cell to show toast after copy
    func didCopyURL(_ sender : UserTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender){
            let url = userViewModelList[indexPath.row].getGithubUrl()
            UIPasteboard.general.string = url
            self.navigationController?.view.makeToast(COPY_TO_CLIPBOARD)
        }
    }
    
    //delegate from empty view to handle reload data after something went wrong
    func didReloadData(_ sender: EmptyView) {
        self.prepareEmptyView(STATUS.loading)
        resetTableView()
    }
    
    
    
}
