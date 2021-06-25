//
//  ListController.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation
import UIKit

protocol ListControllerProtocol {
    var onSelectAd: ((_ ad: Ad) -> Void)? { get set }
}

class ListController: UIViewController, ListControllerProtocol {
    private let viewModel: ListViewModel
    private let tableView = UITableView()

    var onSelectAd: ((_ ad: Ad) -> Void)?
 
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.loadList { error in
            #warning("todo: handle errors + empty state")
            self.tableView.reloadData()
        }
        viewModel.reload = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .done, target: self, action: nil)
        button.tintColor = .white
        navigationItem.setRightBarButton(button, animated: true)
        title = "Petites annonces"
        
        tableView.bindConstraintsToSuperview()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCellClass(ListCell.self)
    }
}

extension ListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withClass: ListCell.self)
        if let data = viewModel.getCellData(at: indexPath.row) {
            cell.configure(with: data)
        }
        return cell
    }
}
