//
//  ViewController.swift
//  Companies
//
//  Created by bwong on 11/10/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        
        view.backgroundColor = UIColor.white
        
        let plusImage = UIImage(named: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: plusImage?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany)) 
    }
    
    func handleAddCompany() {
        print(123)
    }
    
    func setupNavigationStyle() {
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        
        navigationItem.title = "Companies"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = lightRed
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

}

