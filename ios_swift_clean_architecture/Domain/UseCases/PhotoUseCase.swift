//
//  PhotoUseCase.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation

protocol PhotoUseCase {
    func getPhoto(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void)
}
