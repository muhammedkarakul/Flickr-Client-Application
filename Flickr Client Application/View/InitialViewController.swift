//
//  InitialViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 5.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 500
        table.backgroundColor = .black
        table.separatorStyle = .none
        return table
    }()
    
    let photoSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        return searchBar
    }()
    
    private var photoViewModels = [PhotoViewModel]() {
        didSet {
            
            tableView.reloadData()
            
            print("TABLE VIEW RELOADED")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        SVProgressHUD.show()
        
        Service.getRecentPhotos() { (photos, error) in
            
            SVProgressHUD.dismiss()
            
            if let err = error {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                return
            }
            
            self.photoViewModels += photos?.map({return PhotoViewModel(photo: $0)}) ?? []
            
        }
        
    }
    
    private func setupView() {
        
        view.backgroundColor = .black
        title = "Recent Photos"
        
        photoSearchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        view.addSubview(photoSearchBar)
        view.addSubview(tableView)
        
        photoSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(photoSearchBar.snp.bottom)
            make.bottom.right.left.equalTo(0)
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
            fetchData()
        }
        
        guard let photoCell = cell as? PhotoTableViewCell else { return }
        
        photoCell.photoViewModel = photoViewModels[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.photoViewModel = photoViewModels[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        guard let text = searchBar.text else { return }
        
        SVProgressHUD.show()
        
        Service.serachPhoto(withText: text) { (photos, error) in
            
            SVProgressHUD.dismiss()
            
            if let err = error {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                return
            }
            
            self.photoViewModels = photos?.map({return PhotoViewModel(photo: $0)}) ?? []
            
        }
    }

}
