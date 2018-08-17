//
//  PedidosInfoTableViewCell.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 16/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class PedidosInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var clienteLabel: UILabel!
    @IBOutlet weak var nflabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var pedidoLabel: UILabel!
    @IBOutlet weak var quantidadeLabel: UILabel!
    
    
    func PreapareCell(pedido: PedidosModel){
        
        clienteLabel.text = "Cliente: \(pedido.fantasia!)"
        nflabel.text = "NF: \(pedido.nota!)"
        dataLabel.text = "Data: \(pedido.data_e!)"
        valorLabel.text = "Valor: \(pedido.valor!)"
        pedidoLabel.text = "Pedido: \(pedido.cota!)"
        quantidadeLabel.text = "Quantidade: \(Int(pedido.quant!))"
        
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
