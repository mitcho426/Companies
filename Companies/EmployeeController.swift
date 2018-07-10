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
    
    private func fetchEmployees() {
        
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else {
            return
        }
        self.employees = companyEmployees

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
        return employees.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let employee = employees[indexPath.row]
        
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
}
