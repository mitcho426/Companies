//
//  Extensions.swift
//  Companies
//
//  Created by bwong on 11/10/17.
//  Copyright © 2017 mwong. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    static let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
}

extension UIViewController {
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupHandleSaveButton(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackGroundView = UIView()
        lightBlueBackGroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackGroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackGroundView)
        lightBlueBackGroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackGroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackGroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackGroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return lightBlueBackGroundView
    }
    
    func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

