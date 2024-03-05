//
//  Photo.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation

struct Hits: Decodable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth: Int?
    var previewHeight: Int?
    var webformatURL: String?
    var webformatWidth: Int?
    var webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth: Int?
    var imageHeight: Int?
    var imageSize: Int?
    var views: Int?
    var downloads: Int?
    var collections: Int?
    var likes: Int?
    var comments: Int?
    var userId: Int?
    var user: String?
    var userImageURL: String?
}
