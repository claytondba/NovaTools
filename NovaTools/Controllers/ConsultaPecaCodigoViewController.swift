//
//  ConsultaPecaCodigoViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 20/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ConsultaPecaCodigoViewController: UIViewController {

    
    @IBOutlet weak var txtPeca: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier! == "consulta" {
            //let vw = segue.destination as! PecasTableViewController
            //vw.Prefix = txtPeca.text!
        }
        else if segue.identifier == "result" {
            let vw = segue.destination as! PecasTableViewController
            vw.Prefix = txtPeca.text!
        }
        else if(segue.identifier == "logaUsuario")
        {
            
        }
        
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
