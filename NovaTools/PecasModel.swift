//
//  PecasModel.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 10/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation

struct Peca: Codable {
    
    var sr_recno: Int64?
    var codigo: String?
    var codigo_p: String?
    var paralelo: String?
    var descricao: String?
    var local: String?
    var desc_ing: String?
    var desc_esp: String?
    var preco_v: Double?
    var estoque_l: Double?
    var use: String?
    var esptec: String?
    var image: String?
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
