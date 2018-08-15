//
//  PecasDetalheViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 13/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PecasDetalheViewController: UIViewController {

    
    @IBOutlet weak var ivPeca: UIImageView!
    @IBOutlet weak var portuguesLabel: UILabel!
    @IBOutlet weak var inglesLabel: UILabel!
    @IBOutlet weak var espLabel: UILabel!
    @IBOutlet weak var aplicaLabel: UILabel!
    @IBOutlet weak var estoqueLabel: UILabel!
    @IBOutlet weak var acPeca: UIActivityIndicatorView!
    
    
    var PecaEdit: Peca = Peca()
    var PecaEditComplete: Peca = Peca()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acPeca.startAnimating()
        
        if let paralelo = PecaEdit.paralelo {
            self.title = "MIC \(PecaEdit.codigo_p!) \(paralelo)"
        }
        else
        {
            self.title = "MIC \(PecaEdit.codigo_p!)"
        }
        
        if let portugues = PecaEdit.descricao {
            portuguesLabel.text = portugues
        }
        else{
            portuguesLabel.text = "Sem descrição..."
        }
        
        if let ingles = PecaEdit.desc_ing {
            inglesLabel.text = ingles
        }
        else{
            inglesLabel.text = "Sem descrição em inglês..."
        }
        
        if let esp = PecaEdit.desc_esp {
            espLabel.text = esp
        }
        else{
            espLabel.text = "Sem descrição em espanhol..."
        }
        
        if let aplic = PecaEdit.esptec {
            aplicaLabel.text = aplic
        }
        else{
            espLabel.text = "Sem descrição em espanhol..."
        }
        
        if let estoque = PecaEdit.estoque_l {
            estoqueLabel.text = "\(Int(estoque))"
        }
        
        //Recuperando imagem do servidor...
        
        DataManager.loadPecaComplete(peca: PecaEdit.codigo!, onComplete: { (pec) in
            self.PecaEditComplete = pec
            
            DispatchQueue.main.async {
                let data = NSData(base64Encoded: self.PecaEditComplete.image!, options: [])
                //let data = NSData(bytes: self.PecaEdit.image!, length: self.PecaEdit.image!.count)
                let image = UIImage(data: data! as Data)
                self.ivPeca.image = image
                self.acPeca.stopAnimating()
                self.acPeca.isHidden = true
                
                
            }
        }) { (erro) in
            
            DispatchQueue.main.async {
                if erro {
                    self.acPeca.stopAnimating()
                    self.acPeca.isHidden = true
                }
            }
            
        }
   
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
