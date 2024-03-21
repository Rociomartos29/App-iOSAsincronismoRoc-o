//
//  TransformTableViewController.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit
import Combine

class TransformationsTableViewController: UITableViewController {
    // ViewModel y AppState
    private var appState: LoginViewModel?
    private var viewModel: TransformationsViewModel
    
    // Combine
    private var cancellables = Set<AnyCancellable>()
    
    init( viewModel: TransformationsViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.title = "Lista de Transformaciones"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSessions))
        bindUI()
    }
    
    @objc func closeSessions() {
        appState!.closeSessionUser()
    }
    
    func bindUI() {
        self.viewModel.$transformations
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let transformation = viewModel.transformations[indexPath.row]
        cell.textLabel?.text = transformation.name
        // Asigna la imagen de la transformación a la celda si está disponible
        if let imageURL = URL(string: transformation.photo) {
            cell.imageView?.loadImageAsync(from: imageURL)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
