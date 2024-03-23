//
//  HeroTableViewController.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit

import UIKit
import Combine


class HerosTableViewController: UITableViewController {
    //TODO: viewModel, appState, heroes
    private var appState: LoginViewModel
    private var viewModel: HerosViewModel
    
    //Combine
    private var suscriptor = Set<AnyCancellable>()
    
    init(appState: LoginViewModel, viewModel: HerosViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HerosTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.title = "Lista de Heroes"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSessions))
        bindingUI()
        
    }
    @objc func closeSessions(){
        appState.closeSessionUser()
    }
    func bindingUI(){
        self.viewModel.$herosData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.tableView.reloadData()
            })
            .store(in: &suscriptor)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.herosData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HerosTableViewCell
        
        let hero = viewModel.herosData[indexPath.row]
        cell.nameHero.text = hero.name
        cell.imagHero.loadImageAsync(from: URL(string: hero.photo)!)
        cell.isUserInteractionEnabled = true
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Obtener el héroe seleccionado
        let selectedHero = viewModel.herosData[indexPath.row]
        
        // Crear el ViewModel para las transformaciones del héroe seleccionado
        let transformationsViewModel = TransformationsViewModel(useCases: TransformationsUseCase(), hero: selectedHero)
        
        // Verificar si el héroe tiene transformaciones
        Task {
            await transformationsViewModel.getTransform(id: selectedHero.id)
            DispatchQueue.main.async {
                if transformationsViewModel.transform.isEmpty {
                    // Si no hay transformaciones, mostrar una alerta
                    self.showAlert(message: "Este héroe no tiene transformaciones.")
                } else {
                    // Si hay transformaciones, crear y presentar el controlador de vista de la lista de transformaciones
                    let transformationsViewController = TransformationsTableViewController(viewModel: transformationsViewModel)
                    self.navigationController?.pushViewController(transformationsViewController, animated: true)
                }
            }
        }
    }
        
    
    func showAlert(message: String) {
          let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
}

