//
//  CompraItensViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 26/09/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class CompraItensViewController: UIViewController {

    
    @IBOutlet weak var pedido: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var fornecedor: UILabel!
    @IBOutlet weak var condicaoLabel: UILabel!
    @IBOutlet weak var compradorLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var itensTableVIew: UITableView!
    
    let spinner = UIActivityIndicatorView()
    
    
    var Compra: CompraModel = CompraModel()
    var Itens: [ComprasItensModel] = []
    
    func LoadComprasItens(){
        
        DataManager.loadItensCompras(pedido: Compra.codigo!, tipo: Compra.tipo!, onComplete: { (itensCompra) in
            self.Itens = itensCompra
            DispatchQueue.main.async {
                self.itensTableVIew.reloadData()
                self.removeLoadingScreen()
            }
            
        }) { (error) in
            
        }
        
    }
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        //loadingLabel.isHidden = true
        
    }
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor(named: "main")
        spinner.startAnimating()
        itensTableVIew.backgroundView = spinner
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pedido.text = "Pedido: \(Compra.codigo!)"
        data.text = Compra.data
        fornecedor.text = "\(Compra.fantasia!)"
        condicaoLabel.text = "Pgto: \(Compra.desc_pgto!)"
        compradorLabel.text = "Comprador: \(Compra.comprador!)"
        valorLabel.text = formatter.string(from: Compra.valor! as NSNumber)
        //valorLabel.text = Compra.valor
        
        if let tp = Compra.tipo {
            
            switch tp {
            case "o":
                tipoLabel.text = "Outros Produtos"
            case "m":
                tipoLabel.text = "Matéria - Prima"
            default:
                tipoLabel.text = "Peças"
            }
            
        }
        setLoadingScreen()
        LoadComprasItens()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func aprovaPedido(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func reprovaPedido(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension CompraItensViewController: UITableViewDelegate {
    
}

extension CompraItensViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComprasItensTableViewCell
        let compraItem = Itens[indexPath.row]
        
        cell.PrepareCell(with: compraItem)
        
        
        //let comp = Itens[indexPath.row]
        //cell.PrepareCell(compra: comp)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ITENS"
    }
    
}
