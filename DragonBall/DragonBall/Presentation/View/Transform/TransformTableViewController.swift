//
//  TransformTableViewController.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit
import Combine

class TransformationsTableViewController: UITableViewController {
    private var transformations: [Transformation] = []
    private var viewModel: HerosViewModel?
    private var suscriptors = Set<AnyCancellable>()
     
     init(transformations: [Transformation]) {
         self.transformations = transformations
         super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         tableView.register(UINib(nibName: "TransformTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
         
         self.title = "Lista de Transformaciones"
         


     }
    private func binding(){
        self.viewModel!.$transformation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { dataRecived in
                //recargamos la tabla al llegar las transformaciones
                self.tableView.reloadData()
            })
            .store(in: &suscriptors)
    }

    
     
     // MARK: - Table view data source
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return transformations.count
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransformTableViewCell
         
         let transformation = transformations[indexPath.row]
         cell.textLabel?.text = transformation.name
         
         cell.imageView?.loadImageAsync(from: URL(string: transformation.photo)!)
         
         return cell
     }
     
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100   }
 }
