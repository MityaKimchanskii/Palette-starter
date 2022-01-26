//
//  PaletteViewController.swift
//  Palette
//
//  Created by Mitya Kim on 1/25/22.
//  Copyright © 2022 Cameron Stuart. All rights reserved.
//

import UIKit

class PaletteViewController: UIViewController {
    
    //MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var photos: [UnsplashPhoto] = []
    
    var buttons: [UIButton] {
        return [featureButton, randomButton, doubleRainbowButton]
    }

    // MARK: - Lifecycles
    override func loadView() {
        super.loadView()
        addAllSubviews()
        setupButtonStackView()
        constrainTableView()
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemOrange
        configureTableView()
        fetchUnsplash()
        activateButtons()
    }
    
    // MARK: - Helper functions
    func activateButtons() {
        buttons.forEach({ $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)})
        featureButton.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach({ $0.setTitleColor(.lightGray, for: .normal)})
        sender.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
        
        switch sender {
        case featureButton:
            searchForCategory(.featured)
        case randomButton:
            searchForCategory(.random)
        case doubleRainbowButton:
            searchForCategory(.doubleRainbow)
        default:
            searchForCategory(.featured)
        }
    }
    
    func searchForCategory(_ unsplsashRoute: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: unsplsashRoute) { photos in
            DispatchQueue.main.async {
                guard let photos = photos else {
                    return
                }
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    func fetchUnsplash() {
        UnsplashService.shared.fetchFromUnsplash(for: .featured) { photos in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    func addAllSubviews() {
        self.view.addSubview(featureButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setupButtonStackView() {
        buttonStackView.addArrangedSubview(featureButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 16).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 8).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -8).isActive = true
    }
    
    func constrainTableView() {
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: self.safeArea.bottomAnchor, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "photoCell")
    }
    
    // MARK: - Views
    let featureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rundom", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rainbow", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let buttonStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .horizontal
       stackView.alignment = .fill
       stackView.distribution = .equalCentering
       stackView.translatesAutoresizingMaskIntoConstraints = false
        
       return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
}

extension PaletteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PaletteTableViewCell else { return UITableViewCell() }
        
        let photo = photos[indexPath.row]

        cell.photo = photo
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = view.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        
        let outerVerticalPaddingSpace: CGFloat = 2 * SpacingConstants.outerVerticalPadding
        
        let labelSpace: CGFloat = SpacingConstants.smallElementHeight
        
        let objectBuffer: CGFloat = 2 * SpacingConstants.verticalObjectBuffer
        
        let colorPaletteViewSpace: CGFloat = SpacingConstants.mediumElementHeight
        
        return imageViewSpace + outerVerticalPaddingSpace + labelSpace + objectBuffer + colorPaletteViewSpace
    }
    
}
