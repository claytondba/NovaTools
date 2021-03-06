//
//  ComprasTableViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 17/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ComprasTableViewController: UITableViewController {

    var ListaCompras: [CompraModel] = []
    

    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingScreen()
        LoadCompras()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func LoadCompras(){
        
        DataManager.loadCompras(token:Configuration.shared.TokenAPI, onComplete: { (compras) in
            self.ListaCompras = compras
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeLoadingScreen()
            }
            
        }) { (error) in
            
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vw = segue.destination as! CompraItensViewController
        vw.Compra = ListaCompras[tableView.indexPathForSelectedRow!.row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListaCompras.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComprasTableViewCell

        let comp = ListaCompras[indexPath.row]
        
        cell.PrepareCell(compra: comp)

        return cell
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
        
        tableView.backgroundView = spinner
        
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let reprova = UITableViewRowAction(style: .normal, title: "Reprovar") { action, index in
            let comp = self.ListaCompras[index.row]
            comp.opr = "n"
            
            DataManager.aprovaPedido(token: Configuration.shared.TokenAPI, pedido: comp, onComplete: { (result) in
                if result {
                    self.ListaCompras.remove(at: index.row)
                    
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [index], with: .fade)
                    }
                }
                else
                {
                    print("Deu ruim")
                }
                
            })
            
        }
        reprova.backgroundColor = UIColor(named: "second")
        
        let aprova = UITableViewRowAction(style: .normal, title: "Aprovar") { action, index in
            let comp = self.ListaCompras[index.row]
            comp.opr = "s"
            
            DataManager.aprovaPedido(token: Configuration.shared.TokenAPI, pedido: comp, onComplete: { (result) in
                if result {
                    self.ListaCompras.remove(at: index.row)
                    
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [index], with: .fade)
                    }
                }
                else
                {
                    print("Deu ruim")
                }
            })
        }
        aprova.backgroundColor = UIColor(named: "main")
        
        return [reprova, aprova]
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //editingStyle.rawValue = "AProvar"
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
