//
//  LogingViewController.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 17/3/24.
//

import UIKit
import Combine
import CombineCocoa

class LogingViewController: UIViewController {
    
    
    @IBOutlet weak var fondoImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var contraseñaTxt: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    private var user: String = ""
    private var password: String = ""
    
    private var suscriptor = Set<AnyCancellable>()
    
    private var viewModel: LoginViewModel?
    
    init(appState: LoginViewModel){
        self.viewModel = appState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
       
    }
    
    
    func bindingUI(){
        if let emailTxt = self.emailTxt{
            emailTxt.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let usr = data {
                        
                        self?.user = usr
                    }
                }
                .store(in: &suscriptor)
                }
        if let passwordTxt = self.contraseñaTxt{
            passwordTxt.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let pass = data{
                       
                        self?.password = pass
                    }
                }
                .store(in: &suscriptor)
        }
        
        if let loginButon = self.loginButton{
            loginButon.tapPublisher
                .sink { [weak self] _ in
                    if let user = self?.user,
                       let pass = self?.password{
                        self?.viewModel?.loginApp(user: user, pass: pass)
                    }
                }
                .store(in: &suscriptor)
        }
        
        }
    

    @IBAction func entrarButton(_ sender: Any) {
        print("Botón de entrar presionado")
           guard let viewModel = viewModel else {
               print("Error: ViewModel no inicializado")
               return
           }
           
           // Aquí deberías llamar al método para iniciar sesión
           viewModel.loginApp(user: user, pass: password)
       
    }
    

}
