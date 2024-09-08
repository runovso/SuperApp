//
//  AppCell.swift
//  SuperApp
//
//  Created by Sergei Runov on 07.09.2024.
//

import UIKit

final class AppCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let reuseIdentifier = String(describing: AppCell.self)
    
    // MARK: - Subviews
    
    // TODO: App name and icon?
        
    // MARK: - Properties
    
    var appController: UIViewController?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(for app: App) {
        self.appController?.view.removeFromSuperview()
        self.appController?.removeFromParent()
        self.appController = app.controller
        setupLayout()
    }
}

// MARK: - Private setup methods

private extension AppCell {
    
    func setupAppearance() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func setupLayout() {
        if let appView = self.appController?.view {
            contentView.addSubview(appView)
            appView.translatesAutoresizingMaskIntoConstraints = false

            let margins = contentView.readableContentGuide
            NSLayoutConstraint.activate([
                appView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                appView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                appView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                appView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
            ])
        }
    }
}
