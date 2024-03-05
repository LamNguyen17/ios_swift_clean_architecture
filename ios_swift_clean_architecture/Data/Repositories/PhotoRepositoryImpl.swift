//
//  PhotoRepositoryImpl.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation


struct PhotoResult: Decodable {
    var hits: [Hits]?
    var total: Int?
    var totalHits: Int?
}

struct PhotoRepository: PhotoUseCase {
    
    func getPhoto(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        return PhotoDataSourceImpl
            .getPhotoDataSource(pageSize: pageSize)
            .request(returnType: PhotoResult.self){ result in
                switch result {
                case .success(let photoResult):
                    completion(.success(photoResult));
                case .failure(let error):
                    completion(.failure(error));
                }
            }
    }
}
