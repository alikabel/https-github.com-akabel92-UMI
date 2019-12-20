//
//  RepositoryDetailsViewController.swift
//  UMLTask
//
//  Created by Ali Kabel on 20.12.19.
//  Copyright © 2019 Ali Kabel. All rights reserved.
//

import UIKit

final class RepositoryDetailsViewController: UIViewController {
    private let viewModel: RepositoryDetailsViewModel
    private let starsLabel = UILabel()
    
    init(viewModel: RepositoryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        getRepositoryDetails()
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.text = "Repository Full Name: \(viewModel.fullName)"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        view.addSubview(nameLabel)
        
        
        starsLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starsLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            
            starsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            starsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            starsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(getRepositoryDetails), userInfo: nil, repeats: true)

        
    }
    
    @objc private func getRepositoryDetails() {
        viewModel.getRepositoryStarsNumber(success: {
            DispatchQueue.main.async { [weak self] in
                self?.starsLabel.text = "Stars number: \(self?.viewModel.starsNumber ?? 0)"
            }
        }, failure: { error in
            print("Error: \(error)")
        })
    }
}
