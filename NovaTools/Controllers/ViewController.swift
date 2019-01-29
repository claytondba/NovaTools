//
//  ViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 09/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    //@IBOutlet weak var txtPeca: UITextField!
    @IBOutlet weak var userBarButton: UIBarButtonItem!
    //var PecaUser: string
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Configuration.shared.TokenAPI = "";
        
        //Verificação de credenciais salvas de usuário
        if Configuration.shared.TokenAPI == "" || Configuration.shared.User == ""{
            performSegue(withIdentifier: "logaUsuario", sender: self)
        }
        
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if Configuration.shared.User != "" {
            userBarButton.title = Configuration.shared.User
        }
        else {
            userBarButton.title = "Anônimo"
        }
        /*
        print(Configuration.shared.User)
        print(Configuration.shared.Password)
        print(Configuration.shared.TokenAPI)
        print(Configuration.shared.TipoAprovacao)

        userBarButton.title = Configuration.shared.User
        */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier! == "consulta" {
            //let vw = segue.destination as! PecasTableViewController
            //vw.Prefix = txtPeca.text!
        }
        else if segue.identifier == "result" {
            //let vw = segue.destination as! PecasTableViewController
            //vw.Prefix = txtPeca.text!
        }
        else if(segue.identifier == "logaUsuario")
        {
        
        }
        
    }

    @IBAction func userButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout de Usuário", message: "Deseja efetuar o logout do usuário: \(Configuration.shared.User)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Sair", style: .default, handler: { (action) in
            Configuration.shared.Logout()
            self.performSegue(withIdentifier: "logaUsuario", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

