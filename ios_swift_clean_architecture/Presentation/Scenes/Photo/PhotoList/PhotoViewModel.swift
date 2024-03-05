//
//  PhotoListViewController.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation

class PhotoViewModel {
    @Injected var photoUseCase: PhotoUseCase
    var photoResult: PhotoResult?
    
    func getPhotoVM(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        photoUseCase.getPhoto(pageSize: 1){ result in
            switch result {
            case .success(let photoResult):
                self.photoResult = photoResult
                completion(.success(photoResult))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        };
    }
}
