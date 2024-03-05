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
    @Injected var photoUseCase: PhotoUseCase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Photo", comment: "")
        photoUseCase.getPhoto(pageSize: 1){ result in
            switch result {
            case .success(let photoResult):
                print("response_success: \(photoResult)")
                self.apiResult = photoResult
                DispatchQueue.main.async {
                    self.tableViewPhoto.reloadData()
                }
                break
            case .failure(let error):
                print("response_failure: \(error)")
                break
            }
        };
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
        return apiResult.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewPhoto.dequeueReusableCell(withIdentifier: "TableViewPhotoCell")
        else {
            return UITableViewCell()
        }
        cell.textLabel?.text = apiResult.hits?[indexPath.row].user
        return cell
    }
}
