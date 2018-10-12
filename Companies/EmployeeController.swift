//
//  EmployeeController.swift
//  Companies
//
//  Created by bwong on 7/4/18.
//  Copyright © 2018 mwong. All rights reserved.
//

import UIKit
import CoreData

class EmployeeController : UITableViewController {
    
    let cellId = "cellId"
    var company: Company?
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.setupNavigationItems()
        self.fetchEmployees()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = company?.name
    }
    
    var shortNameEmployees = [Employee]()
    var longNameEmployees = [Employee]()
    var reallyLongNameEmployees = [Employee]()
    
    var allEmployees = [[Employee]]()
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {
            return
        }
        
        shortNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count <= 6
            }
            return false
        })
        
        longNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count > 6 && count < 9
            }
            return false
        })
        
        reallyLongNameEmployees = companyEmployees.filter({ (employee) -> Bool in
            if let count = employee.name?.count {
                return count > 9
            }
            return false
        })
        
        allEmployees = [shortNameEmployees, longNameEmployees, reallyLongNameEmployees]
    }
    
    private func setupNavigationItems() {
        self.setupPlusButtonInNavBar(selector: #selector(handleAdd))
    }

    @objc private func handleAdd() {
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = self.company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
}

extension EmployeeController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        employees.append(employee)
        tableView.reloadData()
    }
}

extension EmployeeController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//        let employee = employees[indexPath.row]
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        if let birthday = employee.employeeInformation?.birthday {
            cell.textLabel?.text = "\(employee.name ?? "" ) - \(dateFormatter.string(from:birthday))"
        } else {
            cell.textLabel?.text = employee.name
        }
        
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if section == 0 {
            label.text = "Short Name"
        }
        else if section == 1 {
            label.text = "Long Name"
        }
        else {
            label.text = "Really Long Name"
        }
        
        label.backgroundColor = UIColor.lightBlue
        label.textColor = UIColor.darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
}
