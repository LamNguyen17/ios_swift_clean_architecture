//
//  PhotoNavigator.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import UIKit

struct PhotoNavigator {
    let navigationController: UINavigationController

    func showPhoto() {
        let photoListViewController = Storyboard.load(.photo, type: PhotoListViewController.self)
        photoListViewController.navigator = self
        navigationController.pushViewController(photoListViewController, animated: false)
    }
}

