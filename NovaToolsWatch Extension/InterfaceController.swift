//
//  InterfaceController.swift
//  NovaToolsWatch Extension
//
//  Created by Clayton Oliveira on 28/09/18.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var infoLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        infoLabel.setText("")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func ReiniciarTerminais() {
        
        infoLabel.setText("Comunicando...")
        
        DataManager.reiniciaTerminais(token: "ef3c30d9-f466-4f55-bc1b-4a72ff485fb2", onComplete: { (ret) in
            
            self.infoLabel.setText("OK!")
            
        }) { (ret_bool) in
            self.infoLabel.setText("Erro...")
        }
    }
}
