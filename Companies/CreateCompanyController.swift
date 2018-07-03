//
//  CreateCompanyController.swift
//  Companies
//
//  Created by bwong on 11/10/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit
import CoreData

//Custom delegation
protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            guard let founded = company?.founded else { return }
            datePicker.date = founded
        }
    }
    var delegate: CreateCompanyControllerDelegate?
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Name"
        return tf
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        
        self.setupNavigationItems()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = company != nil ? "Edit Company" : "Create Company"
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
    }
    //CREATE : CORE DATA
    private func createCompany() {
        print("Trying to save...")
        //Step 1 : Get persistentContainer context
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //Step 2 : Create company object so we can insert into context
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        
        //Step 3 : Set company
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        //Step 4 : Perform save on context
        do {
            try context.save()
            dismiss(animated: true, completion: {
                //as! Company because the default type is NSManagedObject
                self.delegate?.didAddCompany(company: company as! Company)
            })
        } catch let saveErr {
            print("Failed to save company: \(saveErr)")
        }
    }
    
    //UPDATE : CORE DATA
    func saveCompanyChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        //if company is not nil, then we are editing
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
        } catch let saveError {
            print("Failed to save company: \(saveError)")
        }
    }
    
    private func setupUI() {
        let lightBlueBackGroundView = UIView()
        lightBlueBackGroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackGroundView)
        lightBlueBackGroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackGroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackGroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackGroundView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueBackGroundView.bottomAnchor).isActive = true
        
        
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
