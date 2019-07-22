//
//  PhotosView.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 22.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SnapKit

class PhotosView: UIView {

    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 500
        table.backgroundColor = .black
        table.separatorStyle = .none
        table.keyboardDismissMode = .onDrag
        return table
    }()
    
    let photoSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(photoSearchBar)
        self.addSubview(tableView)
        
        photoSearchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(photoSearchBar.snp.bottom)
            make.bottom.right.left.equalTo(0)
        }
    }

}
