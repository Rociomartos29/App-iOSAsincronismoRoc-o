//
//  LoginViewController.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import UIKit
import Combine
import CombineCocoa
class LoginViewController: UIViewController {
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var Contraseña: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet var fono: [UIImageView]!
    
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
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func bindingUI(){
        if let emailTxt = self.email{
            emailTxt.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let usr = data {
                        
                        self?.user = usr
                    }
                }
                .store(in: &suscriptor)
        }
        if let passwordTxt = self.Contraseña{
            passwordTxt.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] data in
                    if let pass = data{
                        
                        self?.password = pass
                    }
                }
                .store(in: &suscriptor)
        }
        
        if let loginButton = self.loginButton {
            loginButton.tapPublisher
                .sink { [weak self] _ in
                    guard let email = self?.email.text, !email.isEmpty,
                          let password = self?.Contraseña.text, !password.isEmpty else {
                        self?.showAlert(message: "Correo electrónico o contraseña incorrecto.")
                        return
                    }
                    self?.viewModel?.loginApp(user: email, pass: password)
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

