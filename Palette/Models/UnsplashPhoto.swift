//
//  UnsplashPhoto.swift
//  Palette
//
//  Created by Cameron Stuart on 7/10/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

struct PhotoSearchDictionary: Decodable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    
    let urls: URLGroup
    let description: String?
}

struct URLGroup: Decodable {
    let small: String
    let regular: String
}
