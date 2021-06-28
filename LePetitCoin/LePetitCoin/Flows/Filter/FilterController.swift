//
//  FilterController.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 27/06/2021.
//

import Foundation
import UIKit

protocol FilterControllerType {
    var onFilter: ((_ categories: Categories?) -> Void)? { get set }
    var onDismiss: (() -> Void)? { get set }
}

class FilterController: UIViewController, FilterControllerType {
    var onFilter: ((_ category: Categories?) -> Void)?
    var onDismiss: (() -> Void)?
    
    private var viewModel: FilterViewModelType
    private let tableView = UITableView()
    private let dockedView = DockedView(title: "Appliquer")
    private let headerView = CategoryHeaderView()
    
    init(viewModel: FilterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.onDismiss = {
            self.onDismiss?()
        }
        dockedView.onSelect = {
            self.onFilter?(self.viewModel.categories)
        }
        setupUI()
        setupTableView()
        
        // if some categories are selected, select them in the table view to have an UI indication
        viewModel.cellSelectedRows?.forEach { row in
            self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
        }
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
        tableView.backgroundColor = .white
        tableView.allowsMultipleSelection = true
        // Remove bottom separators
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCellClass(CategoryCell.self)
    }
}

extension FilterController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CategoryCell.self)
        if let category = viewModel.getCategory(at: indexPath.row) {
            cell.configure(with: category)
        }
        
        cell.onSelect = { selected in
            self.viewModel.selectCategory(at: indexPath.row, selected: selected)
        }
        
        return cell
    }
}
