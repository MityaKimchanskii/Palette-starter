//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Mitya Kim on 1/25/22.
//  Copyright © 2022 Cameron Stuart. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    // MARK: - Properties
    var colors: [UIColor]? {
        didSet {
            buildColorBlocks()
        }
    }
    
    // MARK: - LafeCycles
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    
    // MARK: - Helper Methods
    func buildColorBlocks() {
        resetColorBricks()
        
        guard let colors = colors else { return }
        
        for color in colors {
            let colorBrick = generateColor(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded()
    }
    
    func generateColor(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        
        return colorBrick
    }
    
    func resetColorBricks() {
        for subview in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subview)
        }
    }
    
    func setupViews() {
        self.addSubview(colorStackView)
        colorStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    // MARK: - Views
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        
        return stackView
    }()
    
    
}
