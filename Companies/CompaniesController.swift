//
//  ViewController.swift
//  Companies
//
//  Created by bwong on 11/10/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
    let cellID = "cellID"
    var companies = [Company]()
    
    private func fetchCompanies() {
        let persistentContainer = NSPersistentContainer(name: "Companie_Models")
        
        persistentContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed \(err)")
            }
        }
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name ?? "")
            })
        } catch let fetchError {
            print("Failed to fetch companies:", fetchError)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.setupNavigationItems()
        self.setupTableViewSettings()
        self.fetchCompanies()
    }
    
    func setupNavigationItems() {
        navigationItem.title = "Companies"
        let plusImage = UIImage(named: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        let newIndexPath = IndexPath(row: companies.count-1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func setupTableViewSettings() {
//        self.tableView.separatorStyle = .none
        self.tableView.separatorColor = UIColor.white
        self.tableView.backgroundColor = UIColor.darkBlue
        self.tableView.tableFooterView = UIView() //blank view
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID) //You get cell type by using .self
    }
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        let navController = UINavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)
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
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.backgroundColor = UIColor.tealColor
        
        return cell
    }
}


