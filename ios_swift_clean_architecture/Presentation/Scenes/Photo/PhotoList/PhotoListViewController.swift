//
//  PhotoListViewController.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import UIKit
import Kingfisher

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
        tableViewPhoto.register(UINib(nibName: "PhotoCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "PhotoCell")
        tableViewPhoto.dataSource = self
        tableViewPhoto.delegate = self
    }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoResult?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableViewPhoto.dequeueReusableCell(withIdentifier: "PhotoCell") as? PhotoCell
//        else {
//            return UITableViewCell()
//        }
//        cell.textLabel?.text = viewModel.photoResult?.hits?[indexPath.row].user
//        return cell
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as? PhotoCell {
            if let url = URL(string: viewModel.photoResult?.hits?[indexPath.row].previewURL ?? "") {
                cell.imageViewThumbnail.kf.setImage(with: url)
            }
            cell.labelUser.text = viewModel.photoResult?.hits?[indexPath.row].user
            
            cell.labelTags.text = "Thẻ: \(viewModel.photoResult?.hits?[indexPath.row].tags ?? "")"
            // viewModel.photoResult?.hits?[indexPath.row].likes
            
            let str = viewModel.photoResult?.hits?[indexPath.row].likes != nil ? "\(viewModel.photoResult?.hits?[indexPath.row].likes!)" : ""
            cell.labelLikes.text = "Lượt thích: \(str)"
//            cell.labelComments.numberOfLines = 1
//            cell.labelComments.lineBreakMode = .byWordWrapping
//            cell.labelComments.text = "Bình luận: \(viewModel.photoResult?.hits?[indexPath.row].comments ?? "")"
            return cell
        }
        return UITableViewCell()
    }
}
