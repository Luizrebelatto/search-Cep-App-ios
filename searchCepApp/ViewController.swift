//
//  ViewController.swift
//  searchCepApp
//
//  Created by Luiz Gabriel Rebelatto Bianchi on 21/10/24.
//

import UIKit

class ViewController: UIViewController {
    lazy var searchTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Search your Cep"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var fieldCep: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.keyboardType = .decimalPad
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleSearchCep), for: .touchDown)
        button.addTarget(self, action: #selector(handleSearchCep), for: [.touchUpInside, .touchUpOutside])
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setConstraints()
        view.backgroundColor = .yellow
    }
    
    private func setHierarchy(){
        view.addSubview(searchTitle)
        view.addSubview(fieldCep)
        view.addSubview(searchButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            searchTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fieldCep.topAnchor.constraint(equalTo: searchTitle.bottomAnchor, constant: 20),
            fieldCep.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldCep.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fieldCep.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: fieldCep.bottomAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: fieldCep.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 60),
            searchButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    @objc func handleSearchCep(){
        print("Search")
    }
}
