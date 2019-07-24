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
    
    private var currentPage: Int = 1 {
        didSet {
            getFlickrRecentPhotos()
        }
    }
    
    private lazy var photosView = PhotosView()
    
    private var flickrPagedImageResult: FlickrPagedImageResult?
    
    private var photoViewModels = [PhotoCellViewModel]() {
        didSet {
            photosView.tableView.reloadData()
        }
    }
    
    // MARK: - View Setups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        //fetchData()
        
        getFlickrRecentPhotos()
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
    
    private func getFlickrRecentPhotos() {
        
        SVProgressHUD.show()
        
        Service.shared.getRecentPhotos(with: currentPage) { (flickrPagedImageResult, error) in
            
            SVProgressHUD.dismiss()
            
            if let err = error {
                print("ERROR: \(err)")
                return
            }
            
            print("API RETURNED PAGE: \(flickrPagedImageResult?.page ?? 0)")
            
            guard let pagedImageResult = flickrPagedImageResult else { return }
            
            self.flickrPagedImageResult = pagedImageResult
            
            self.photoViewModels = pagedImageResult.photo?.map({return PhotoCellViewModel(photo: $0)}) ?? []
            
        }
    }

}

// MARK: - Table View Data Source

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else { return PhotoTableViewCell() }
        
        if indexPath.row < photoViewModels.count {
            let photoViewModel = photoViewModels[indexPath.row]

            photoViewModel.configure(cell)

        }
        
        return cell
    }
    
}

// MARK: - Table View Delegate

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print("WILL DISPLAY CELL: \(indexPath.row) OF PAGE: \(currentPage)")
        
        if photoViewModels.count - 1 == indexPath.row {
            
            guard let maxPageNumber = flickrPagedImageResult?.pages else { return }
            
            if currentPage < maxPageNumber {
                currentPage += 1
                tableView.setContentOffset(.zero, animated: false)
            } else {
                SVProgressHUD.showError(withStatus: "No more photo available!")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        guard let photo = photoViewModels[indexPath.row].photo else { return }
        detailViewController.photoDetailViewModel = PhotoDetailViewModel(photo: photo)
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
        
        Service.shared.serachPhoto(withText: text) { (photos, error) in
            
            SVProgressHUD.dismiss()
            
            if let err = error {
                SVProgressHUD.showError(withStatus: err.localizedDescription)
                return
            }
            
            self.photoViewModels = photos?.map({return PhotoCellViewModel(photo: $0)}) ?? []
            
        }
    }
}
