//
//  PecasDescricaoTableViewCell.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 22/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PecasDescricaoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var micLabel: UILabel!
    @IBOutlet weak var estoqueLabel: UILabel!
    @IBOutlet weak var obsLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    
    
    func PrepareCell(peca: Peca){
        estoqueLabel.text = "Estoque: (\(Int(peca.estoque_l!)))"
        
        if let paralelo = peca.paralelo {
            micLabel.text = "MIC \(peca.codigo_p!) \(paralelo)"
        }
        else{
            micLabel.text = "MIC \(peca.codigo_p!)"
        }
        //cell.textLabel!.text = "MIC \(peca.codigo_p!) )"
        obsLabel.text = "Descrição: \(peca.descricao!)"
        
        if let orig = peca.use {
            originalLabel.text = orig
        }
        else{
            originalLabel.text = "Sem código original"
        }
        
        if let loc = peca.local {
            localLabel.text = loc
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
