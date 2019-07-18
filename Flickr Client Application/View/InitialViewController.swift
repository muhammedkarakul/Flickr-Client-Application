//
//  InitialViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 5.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import SVProgressHUD

class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // MARK: - Properties
    
    private var currentPage = 1
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 340
        table.backgroundColor = .black
        table.separatorStyle = .none
        return table
    }()
    
    private var photoViewModels = [PhotoViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        SVProgressHUD.show()
        
        Service.getRecentPhotos(withPage: String(currentPage)) { (photos, error) in
            
            SVProgressHUD.dismiss()
            
            if let err = error {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                return
            }
            
            self.photoViewModels += photos?.map({return PhotoViewModel(photo: $0)}) ?? []
            
            self.tableView.reloadData()
        }
        
    }
    
    private func setupView() {
        
        view.backgroundColor = .black
        title = "Recent Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.equalTo(0)
            make.bottom.right.equalTo(0)
        }
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        
        //cell.photoViewModel = photoViewModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print("Current Displayed Cell: \(indexPath.row)")
        
        if indexPath.row + 1 == photoViewModels.count {
            print("TURN THE PAGE")
            
            currentPage = currentPage + 1
            
            fetchData()
        }
        
        guard let photoCell = cell as? PhotoTableViewCell else { return }
        
        photoCell.photoViewModel = photoViewModels[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Current Removed Cell: \(indexPath.row)")
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row: \(indexPath.row)")
    }
    
    

}
