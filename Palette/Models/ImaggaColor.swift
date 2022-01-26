//
//  ImaggaColor.swift
//  Palette
//
//  Created by Cameron Stuart on 7/10/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation

struct ImaggaColorResponse: Decodable {
    let result: ColorDictionaries
}

struct ColorDictionaries: Decodable {
    let colors: ColorResults
}

struct ColorResults: Decodable {
    let imaggaColors: [ImaggaColor]
    
    enum CodingKeys: String, CodingKey {
        case imaggaColors = "image_colors"
    }
}

struct ImaggaColor: Decodable {
    let red: Int
    let green: Int
    let blue: Int
    
    enum CodingKeys: String, CodingKey {
        case red = "r"
        case green = "g"
        case blue = "b"
    }
}
