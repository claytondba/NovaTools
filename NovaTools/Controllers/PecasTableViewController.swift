//
//  PecasTableViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 10/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PecasTableViewController: UITableViewController {

    var ListaPecas: [Peca] = []
    var Prefix: String = ""
    var label = UILabel()
    
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Nenhum resultado encontrado!"
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        
        setLoadingScreen()
        LoadPecas()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func LoadPecas() {
      
        DataManager.loadPecas(prefix: Prefix, onComplete: {(pecas) in
            self.ListaPecas = pecas
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeLoadingScreen()
                
                if self.ListaPecas.count == 0 {
                    self.tableView.backgroundView = self.label
                }
                else {
                    self.tableView.backgroundView = nil
                }
                
            }
            
        },onError: {(erro) in
            
            DispatchQueue.main.async {
                
                self.removeLoadingScreen()
                print(erro.rawValue)
                self.tableView.backgroundView = self.label
            }
            
            
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PecasDetalheViewController
        let peca = ListaPecas[tableView.indexPathForSelectedRow!.row]
        
        vc.PecaEdit = peca
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return ListaPecas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PecasTableViewCell

        cell.PrepareCell(peca: ListaPecas[indexPath.row])


        return cell
    }
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
    
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor(named: "main")
        spinner.startAnimating()
        tableView.backgroundView = spinner
      
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



}

