//
//  PedidosInfoViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 16/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PedidosInfoViewController: UIViewController {
    

    @IBOutlet weak var tableview: UITableView!
    
    var PedidosLista: [PedidosModel] = []
    var PecaEdit: Peca?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPedidos()
        // Do any additional setup after loading the view.
    }

    func LoadPedidos(){
        
        DataManager.loadPedidoPeca(peca: PecaEdit!.codigo!, onComplete: { (pedidos) in
            self.PedidosLista = pedidos
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }) { (erro) in
    
            
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) //as! PecasTableViewCell
        let p = PedidosLista[indexPath.row]
        
        cell.textLabel?.text = "Pedido: \(p.cota!) Nota: \(p.nota!)"
        cell.detailTextLabel?.text = "Cliente: \(p.fantasia!)"
        
        return cell
    }
    
    
    
}
extension PedidosInfoViewController: UITableViewDelegate{
    
}
