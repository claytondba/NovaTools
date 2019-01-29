//
//  ComprasItensTableViewCell.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 26/09/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ComprasItensTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descricaoLabel: UIView!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var quantidadeLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func PrepareCell(with peca: ComprasItensModel) {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = "R$ "
        formatter.alwaysShowsDecimalSeparator = true
        
        descLabel.text = peca.descricao
        quantidadeLabel.text = "Quantidade: \(peca.quant!)"
        valorLabel.text = "Valor: \(formatter.string(from: peca.valor! as NSNumber)!)"
        totalLabel.text = "Total: \(formatter.string(from: peca.valor_t! as NSNumber)!)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
