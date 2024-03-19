//
//  HerosTableViewController.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

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
        cell.imagHero.loadImageRemote(url: URL(string: hero.photo)!)

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
            // Obtener el héroe seleccionado
            let selectedHero = viewModel.herosData[indexPath.row]
            
            // Configurar el DetailViewController y pasar el héroe seleccionado
            let detailViewController = DetailViewController()
            detailViewController.hero = selectedHero
            
            // Presentar el DetailViewController
            navigationController?.pushViewController(detailViewController, animated: true)
       }
    
}
