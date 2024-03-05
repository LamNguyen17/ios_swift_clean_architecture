//
//  PhotoDataSourceImpl.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

enum PhotoDataSourceImpl: RestApi {
    case getPhotoDataSource(pageSize: Int)

    var path: String {
        switch self {
        case .getPhotoDataSource(let pageSize):
            return "?key=\(Config.current.apiKey)&page=\(pageSize)&per_page=30"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPhotoDataSource:
            return .get
        }
    }
}
