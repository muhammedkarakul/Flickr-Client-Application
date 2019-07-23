//
//  InitialViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 5.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SVProgressHUD

class PhotosViewController: UIViewController {

    // MARK: - Properties
    
    private let photosView = PhotosView()
    
    private var photoViewModels = [PhotoViewModel]() {
        didSet {
            photosView.tableView.reloadData()
        }
    }
    
    // MARK: - View Setups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        fetchData()
    }
    
    private func setupView() {
        
        view.backgroundColor = .black
        title = "Recent Photos"
        
        view.addSubview(photosView)
        
        photosView.photoSearchBar.delegate = self
        
        photosView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        setupTableView()
    }
    
    private func setupTableView() {
        photosView.tableView.delegate = self
        photosView.tableView.dataSource = self
        photosView.tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
    
    // MARK: - Network
    
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

}

// MARK: - Table View Data Source

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        
        if indexPath.row < photoViewModels.count {
            let photoViewModel = photoViewModels[indexPath.row]
            
            photoViewModel.configure(cell)
            
        }
        
        
        return cell
    }
    
}

// MARK: - Table View Delegate

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.photoViewModel = photoViewModels[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - Search Bar Delegate

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        guard let text = searchBar.text else { return }
        
        photosView.tableView.setContentOffset(.zero, animated: true)
        
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
