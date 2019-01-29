//
//  LogarViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 20/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class LogarViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var acLogin: UIActivityIndicatorView!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(LogarViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogarViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        txtLogin.delegate = self
        txtPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtLogin {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword {
            view.endEditing(true)
            btnLogar(btnLogin)
        }
        
        return true
    }
    
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        acLogin.isHidden = true
        acLogin.stopAnimating()
        
    }
    @IBAction func btnLogar(_ sender: Any) {
        
        btnLogin.isEnabled = false;
        btnLogin.backgroundColor = .gray
        let User = UserModel()
        
        User.user = txtLogin.text!
        User.password = txtPassword.text!
        
        DispatchQueue.main.async {
            self.acLogin.startAnimating()
            DataManager.getUserToken(user: User, onComplete: { (usr) in
                Configuration.shared.User = usr!.user!
                Configuration.shared.Password = usr!.password!
                Configuration.shared.TokenAPI = usr!.token!
                
                if Configuration.shared.TokenAPI != "" {
                    
                    Configuration.shared.defaults.synchronize()
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Sem acesso ao App", message: "Parece que seu usuário ainda não foi liberado para acesso ao App!", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.acLogin.stopAnimating()
                        self.btnLogin.isEnabled = true
                        self.txtLogin.becomeFirstResponder()
                        self.btnLogin.backgroundColor = UIColor(named: "main")
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            }) { (error) in
               
                let alert = UIAlertController(title: "Erro", message: "Erro ao efetuar o login", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.acLogin.stopAnimating()
                    self.btnLogin.isEnabled = true
                    self.txtLogin.becomeFirstResponder()
                    self.btnLogin.backgroundColor = UIColor(named: "main")
                }))
                print(error.rawValue)
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
}
