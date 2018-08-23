//
//  ConsultaPecaPescricaoViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 22/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ConsultaPecaPescricaoViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var ListaPecas: [Peca] = []
    var CurrentPage = 0
    var DesricaoPeca = ""
    var LoadingPecas = false
    
    /// View which contains the loading text and the spinner
    let loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    let loadingLabel = UILabel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func LoadPecas(){
        
        LoadingPecas = true
        DataManager.loadPecasDescricao(descricao: DesricaoPeca, page: CurrentPage){(pecas) in
            self.ListaPecas = pecas
            DispatchQueue.main.async {
                print("Página: \(self.CurrentPage) Descricao: \(self.DesricaoPeca)")
                self.tableview.reloadData()
                self.removeLoadingScreen()
                //self.removeLoadingScreen()
                self.LoadingPecas = false
                
                if self.ListaPecas.count == 0 {
                    //self.tableView.backgroundView = self.label
                }
                else{
                    //                  self.tableView.backgroundView = nil
                }
                
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PecasDetalheViewController
        let peca = ListaPecas[tableview.indexPathForSelectedRow!.row]
        
        vc.PecaEdit = peca
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        loadingLabel.textAlignment = .center
        setLoadingScreen()
        LoadPecas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableview.frame.width / 2) - (width / 2)
        let y = (tableview.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "   Carregando..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableview.addSubview(loadingView)
        
    }


}

extension ConsultaPecaPescricaoViewController: UITableViewDelegate {
    
}

extension ConsultaPecaPescricaoViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ListaPecas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PecasDescricaoTableViewCell
        
        cell.PrepareCell(peca: ListaPecas[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //if indexPath.row == ListaPecas.count - 10 {
        //    print("Página: \(CurrentPage) Linha: \(indexPath.row) Total: \(ListaPecas.count)")
        //    CurrentPage += 1
         //   LoadPecas()
        //}
    }

}

extension ConsultaPecaPescricaoViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        DesricaoPeca = searchBar.text!
        setLoadingScreen()
        //CurrentPage = 0
        //ListaPecas.removeAll()
        //DesricaoPeca = ""
        LoadPecas()
    }
    
}


