//
//  PhotoListViewController.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import UIKit


class PhotoListViewController: UIViewController {
    var navigator: PhotoNavigator!
    var apiResult = PhotoResult()
    
    @IBOutlet weak var tableViewPhoto: UITableView!
    var viewModel = PhotoViewModel()
    @Injected var photoUseCase: PhotoUseCase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Photo", comment: "")
        viewModel.getPhotoVM(pageSize: 1) { result in
            switch result {
            case .success:
                self.tableViewPhoto.reloadData()
            case .failure(let error):
                print("Failed to fetch users: \(error)")
            }
        }
        configUI()
    }
    
    private func configUI() {
        tableViewPhoto.register(UITableViewCell.self,
                                forCellReuseIdentifier: "TableViewPhotoCell")
        tableViewPhoto.dataSource = self
        tableViewPhoto.delegate = self
    }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoResult?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewPhoto.dequeueReusableCell(withIdentifier: "TableViewPhotoCell")
        else {
            return UITableViewCell()
        }
        cell.textLabel?.text = viewModel.photoResult?.hits?[indexPath.row].user
        return cell
    }
}
