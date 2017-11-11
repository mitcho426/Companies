//
//  ViewController.swift
//  Companies
//
//  Created by bwong on 11/10/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    
    let cellID = "cellID"
    
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Salesforce", founded: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        
        view.backgroundColor = UIColor.white
        
        setupTableViewSettings()
        
        let plusImage = UIImage(named: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    func setupTableViewSettings() {
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.darkBlue
        self.tableView.tableFooterView = UIView() //blank view
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func handleAddCompany() {
        print(123)
    }
    
    func setupNavigationStyle() {
        
        navigationItem.title = "Companies"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let company = companies[indexPath.row]
        
        cell.textLabel?.text = company.name
//        cell.detailTextLabel.text = company.founded
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.backgroundColor = UIColor.tealColor
        
        return cell
    }

}

