//
//  AdController.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol AdControllerType {
    
}

class AdController: UIViewController, AdControllerType {
    private let viewModel: AdViewModelType
    private let tableView = UITableView()
    private let dockedView = DockedView(title: "Contacter")
    
    private enum AdCells: Int, CaseIterable {
        case ImageCell, InfosCell, DescriptionCell
    }
   
    
    init(viewModel: AdViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([tableView, dockedView])
        
        tableView.bindConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        dockedView.bindConstraints([
            dockedView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            dockedView.leftAnchor.constraint(equalTo: view.leftAnchor),
            dockedView.rightAnchor.constraint(equalTo: view.rightAnchor),
            dockedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.accessibilityIdentifier = "adTableView"
        tableView.backgroundColor = .white
        // Remove bottom separators
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCellClass(AdImageCell.self)
        tableView.registerCellClass(AdInfosCell.self)
        tableView.registerCellClass(AdDescriptionCell.self)
    }
}

extension AdController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AdCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case AdCells.ImageCell.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: AdImageCell.self)
            cell.accessibilityIdentifier = "adImageCell"
            cell.configure(with: viewModel.imageViewData)
            return cell
        case AdCells.InfosCell.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: AdInfosCell.self)
            cell.accessibilityIdentifier = "adInfosCell"
            cell.configure(with: viewModel.infosViewData)
            return cell
        case AdCells.DescriptionCell.rawValue:
            let cell = tableView.dequeueReusableCell(withClass: AdDescriptionCell.self)
            cell.accessibilityIdentifier = "adDescriptionCell"
            cell.configure(with: viewModel.description)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        return UITableView.automaticDimension
    }
}
