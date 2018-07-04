//
//  CompanyCell.swift
//  Companies
//
//  Created by bwong on 7/4/18.
//  Copyright © 2018 mwong. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            if let name = company?.name, let founded = company?.founded {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                let dateString = "\(name) - Founded: \(foundedDateString)"
                nameFoundedDateLabel.text = dateString
            } else {
                nameFoundedDateLabel.text = company?.name
            }
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "select_photo_empty")
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Company name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.tealColor
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(companyImageView)
        companyImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addSubview(nameFoundedDateLabel)
        nameFoundedDateLabel.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 8).isActive = true
        nameFoundedDateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameFoundedDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameFoundedDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
