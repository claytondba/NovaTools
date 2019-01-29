//
//  PedidosInfoViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 16/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PedidosInfoViewController: UIViewController {
    

    @IBOutlet weak var pecaLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var PedidosLista: [PedidosModel] = []
    var PecaEdit: Peca?
    let spinner = UIActivityIndicatorView()
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Nenhum pedido encontrado!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        if let paralelo = PecaEdit!.paralelo {
            pecaLabel.text = "MIC \(PecaEdit!.codigo_p!) \(paralelo)"
        }
        else
        {
            pecaLabel.text = "MIC \(PecaEdit!.codigo_p!)"
        }
        setLoadingScreen()
        LoadPedidos()
        // Do any additional setup after loading the view.
    }

    func LoadPedidos(){
        
        DataManager.loadPedidoPeca(peca: PecaEdit!.codigo!, onComplete: { (pedidos) in
            self.PedidosLista = pedidos
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.removeLoadingScreen()
                if self.PedidosLista.count == 0 {
                    self.tableview.backgroundView = self.label
                }
                else {
                    self.tableview.backgroundView = nil
                }
            }
        }) { (erro) in
    
            self.label.text = "Problemas recuperando pedidos deste item!"
            self.tableview.backgroundView = self.label
            
        }
    }
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        
    }
    private func setLoadingScreen() {
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor(named: "main")
        spinner.startAnimating()
        
        tableview.backgroundView = spinner
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fechar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PedidosInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PedidosLista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PedidosInfoTableViewCell
        let p = PedidosLista[indexPath.row]
        
        cell.PreapareCell(pedido: p)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RESUMO VENDAS"
    }
    
}
extension PedidosInfoViewController: UITableViewDelegate{
    
}
