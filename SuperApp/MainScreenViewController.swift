//
//  MainScreenViewController.swift
//  SuperApp
//
//  Created by Sergei Runov on 07.09.2024.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Suviews
    
    private let tableView = UITableView()
    private let changeLayoutModeButton = UIBarButtonItem()
    
    // MARK: - Properties
    
    private var viewMode: ViewMode = .compact
    private lazy var apps: [App] = {
        let location = App.location
        let weather = App.weather(weatherApiUrl: Constants.weatherApiUrl,
                                  weatherApiKey: Constants.weatherApiKey,
                                  imageApiUrl: Constants.imageApiUrl)
        return [
            location,
            weather,
            location,
            weather,
            location,
            weather,
            location,
            weather,
            location,
            weather
        ]
    }()
    
    // MARK: - View Modes
    
    enum ViewMode: String {
        case compact, halfscreen, fullscreen
    }
    
    // MARK: - Lifecycyle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInteraction()
        setupHierarchy()
        setupAppearance()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }    
}

// MARK: - Private setup methods

private extension MainScreenViewController {
    
    func setupInteraction() {
        tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupAppearance() {
        view.backgroundColor = .secondarySystemBackground
        
        title = "Select an app"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = changeLayoutModeButton
        
        changeLayoutModeButton.image = UIImage(systemName: "rectangle.grid.1x2")
        changeLayoutModeButton.target = self
        changeLayoutModeButton.action = #selector(changeLayoutMode)
        
        tableView.backgroundColor = .clear
        tableView.insetsContentViewsToSafeArea = true
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorStyle = .none
    }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupViewModeFor(cell: UITableViewCell) {
        guard let cell = cell as? AppCell else { return }
        guard var controller = cell.appController as? AppProtocol else { return }
        controller.viewMode = viewMode.rawValue
    }
    
    @objc func changeLayoutMode() {
        let imageName = viewMode == .halfscreen ? "text.justify" : "rectangle.grid.1x2"
        changeLayoutModeButton.image = UIImage(systemName: imageName)
        viewMode = viewMode == .compact ? .halfscreen : .compact
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.reuseIdentifier, for: indexPath) as? AppCell else {
            fatalError("Unexpected fail while trying to dequeue cell or cast it to AppCell")
        }
        cell.configure(for: apps[indexPath.row])
        setupViewModeFor(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard var vc = apps[indexPath.row].controller as? AppProtocol else { return }
        vc.viewMode = ViewMode.fullscreen.rawValue
        present(vc as! UIViewController, animated: true)
    }
}

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.safeAreaLayoutGuide.layoutFrame.size.height
        return viewMode == .compact ? height / 8 : height / 2
    }
}
