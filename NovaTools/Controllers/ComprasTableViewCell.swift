//
//  ComprasTableViewCell.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 17/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ComprasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pedidoLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var fornecedorLabel: UILabel!
    @IBOutlet weak var condicaoLabel: UILabel!
    @IBOutlet weak var compradorLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var tipoCompraLabel: UILabel!
    
    
    
    func PrepareCell(compra: CompraModel) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        pedidoLabel.text = "Pedido: \(compra.codigo!)"
        dataLabel.text = compra.data!
        fornecedorLabel.text = compra.fantasia!
        condicaoLabel.text = "Condição: \(compra.desc_pgto!)"
        compradorLabel.text = "Comprador: \(compra.comprador!)"
        let compraValor = formatter.string(for: compra.valor!)!
        valorLabel.text = "\(compraValor)"
        
        if let tp = compra.tipo {
            
            switch tp {
            case "o":
                tipoCompraLabel.text = "Outros Produtos"
            case "m":
                tipoCompraLabel.text = "Matéria - Prima"
            default:
                tipoCompraLabel.text = "Peças"
            }
            
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
