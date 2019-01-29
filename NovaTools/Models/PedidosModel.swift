//
//  PedidosModel.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 16/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation

class PedidosModel: Codable {
    
    var peca: String?
    var cota: String?
    var data_e: String?
    var fantasia: String?
    var quant: Double?
    var valor: Double?
    var nota: String?
    var recnoValue: Int64?
    var fieldRecno: String?
    var fileds: String?
    var linkFields: Bool?
    var entity: String?
    var primitive: Bool?
    var padPrimitive: Int?
    var primitiveCondition: String?
    var lockUp: String?
    var customOrder: String?
    var usuario: String?
    var noAuditTable: Bool?
    var changePrimitiveController: Bool?
    var namePrimitiveController: String?
}
