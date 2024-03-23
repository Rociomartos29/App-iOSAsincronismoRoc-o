//
//  TransformTableViewController.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit
import Combine

class TransformationsTableViewController: UITableViewController {
    private var appState: LoginViewModel?
       private var viewModel: TransformationsViewModel
       
       // Combine
       private var cancellables = Set<AnyCancellable>()
       
       init(viewModel: TransformationsViewModel) {
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

           bindUI()
       }
       

       
       func bindUI() {
           viewModel.$transform
                      .receive(on: DispatchQueue.main)
                      .sink { [weak self] _ in
                          self?.tableView.reloadData() // Recargar la tabla cuando se actualicen los datos
                      }
                      .store(in: &cancellables)
       }
       
       // MARK: - Table view data source
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.transform.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           let transformation = viewModel.transform[indexPath.row]
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
