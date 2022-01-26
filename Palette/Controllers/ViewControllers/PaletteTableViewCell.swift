//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Mitya Kim on 1/25/22.
//  Copyright © 2022 Cameron Stuart. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    // MARK: - Properties
    var photo: UnsplashPhoto?{
        didSet {
            updateViews()
        }
    }
    
    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        addAllSubviews()
        constrainImageView()
        constraintTitleLabel()
        constraintColorPaletteView()
    }
    
    
    // MARK: - Helper methods
    func updateViews() {
        guard let photo = photo else { return }
        fetchAndSetImage(for: photo)
        fetchAndSetColorStack(for: photo)
        paletteTitleLable.text = photo.description ?? "No description"

    }
    
    func fetchAndSetImage(for unsplashPhoto: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: unsplashPhoto) { image in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColorStack(for unsplashPhoto: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: unsplashPhoto.urls.regular) { colors in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    func addAllSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLable)
        self.addSubview(colorPaletteView)
    }
    
    func constrainImageView() {
        let imageViewWidth = self.contentView.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        paletteImageView.anchor(top: self.contentView.topAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.outerVerticalPadding, paddingBottom: 0, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: imageViewWidth, height: imageViewWidth)
    }
    
    func constraintTitleLabel() {
        paletteTitleLable.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: 0, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.smallElementHeight)
    }
    
    func constraintColorPaletteView() {
        colorPaletteView.anchor(top: paletteTitleLable.bottomAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.outerVerticalPadding, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.mediumElementHeight)
    }
    
    // MARK: - Views:
    let paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
            
        return imageView
    }()
    
    let paletteTitleLable: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        
        return paletteView
    }()
    
}
