//
//  CreateEmployeeController.swift
//  Companies
//
//  Created by bwong on 7/4/18.
//  Copyright © 2018 mwong. All rights reserved.
//

import UIKit
import CoreData

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var delegate: CreateEmployeeControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkBlue
        self.setupNavigationItems()
        self.setupUI()
    }
    
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
    
    private func setupNavigationItems() {
        navigationItem.title = "Create Employee"
        self.setupCancelButton()
        self.setupHandleSaveButton(selector: #selector(handleSave))
    }
    
    private func setupUI() {
        _ = self.setupLightBlueBackgroundView(height: 350)
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
    }
    
    @objc private func handleSave() {
        print("Trying to save...")
        guard let employeeName = nameTextField.text else {return}
        
        let tuple = CoreDataManager.shared.createEmployee(name: employeeName)
        let error = tuple.1
        
        if let e = error {
            print(e)
        } else {
            dismiss(animated: true, completion: {
                let employee = tuple.0
                self.delegate?.didAddEmployee(employee: employee!)
            })
        }
        
    }
}
