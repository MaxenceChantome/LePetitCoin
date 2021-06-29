//
//  ListController.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation
import UIKit

protocol ListControllerType {
    var onSelectAd: ((_ ad: Ad,_ category: String) -> Void)? { get set }
    var onFilter: ((_ categories: Categories?) -> Void)? { get set }
}

class ListController: UIViewController, ListControllerType {
    var onSelectAd: ((_ ad: Ad,_ category: String) -> Void)?
    var onFilter: ((_ categories: Categories?) -> Void)?
    
    private var viewModel: ListViewModelType
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .whiteLarge)
    private let emptyStateView = EmptyStateView()
    
    init(viewModel: ListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyStateView.onRetry = {
            self.reloadData()
        }
        viewModel.reloadUI = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        spinner.hidesWhenStopped = true
        reloadData()
        setupUI()
        setupTableView()
        setupNavBar()
    }
    
    private func reloadData() {
        spinner.startAnimating()
        viewModel.loadList { error in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                if let error = error {
                    self.emptyStateView.setTitle(error)
                    self.emptyStateView.isHidden = false
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([tableView, spinner])
        emptyStateView.isHidden = true
        
        tableView.bindConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        spinner.bindConstraintsToSuperview()
        tableView.backgroundView = emptyStateView
    }
    
    private func setupNavBar() {
        title = "Petites annonces"
        
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .done, target: self, action: #selector(filterPushed))
        filterButton.tintColor = .white
        filterButton.accessibilityIdentifier = "filterButton"
        navigationItem.setRightBarButton(filterButton, animated: true)
    }
    
    private func setupTableView() {
        tableView.accessibilityIdentifier = "listTableView"
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCellClass(ListCell.self)
    }
    
    @objc private func filterPushed() {
        onFilter?(viewModel.categories)
    }
}

extension ListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Set empty state view if needed
        if viewModel.hasAlreadyLoadData, viewModel.rowCount == 0 {
            self.emptyStateView.setTitle("Aucune annonce n'a été trouvée 😥")
            self.emptyStateView.isHidden = false
        }
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withClass: ListCell.self)
        cell.accessibilityIdentifier = "listCell_\(indexPath.row)"
        if let data = viewModel.getCellData(at: indexPath.row) {
            cell.configure(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let adInfos = viewModel.getAd(at: indexPath.row) {
            onSelectAd?(adInfos.ad, adInfos.category)
        }
    }
}
