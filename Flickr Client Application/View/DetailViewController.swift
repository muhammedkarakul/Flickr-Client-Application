//
//  DetailViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 18.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    public var photoViewModel: PhotoViewModel?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Detail"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        setupViews()
    }
    
    private func setupViews() {
        
    }

}
