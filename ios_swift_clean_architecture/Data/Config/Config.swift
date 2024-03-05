//
//  Config.swift
//  ios_swift_clean_architecture
//
//  Created by Lam Nguyen Tuan on 04/03/2024.
//

import Foundation

protocol EnvConfiguration {
    var baseUrl: String { get }
    var mockEnabled: Bool { get }

}

struct Config {
    // TODO: automatically environment switch by Bundle Id
    static let current = Dev()

    struct Dev: EnvConfiguration {
        let baseUrl = "https://pixabay.com/api"
        let apiKey = "10378494-67ad2479ecf48567970bc1f0e"
        let mockEnabled = false
    }

    struct Prod: EnvConfiguration {
        let baseUrl = "https://pixabay.com/api"
        let apiKey = "10378494-67ad2479ecf48567970bc1f0e"
        let mockEnabled = false
    }
}
