//
//  InitialViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 5.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 340
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Initial View"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FlickrTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

}
