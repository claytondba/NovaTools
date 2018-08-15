//
//  ViewController.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 09/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPeca: UITextField!
    //var PecaUser: string
    @IBAction func consultarPeca(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vw = segue.destination as! PecasTableViewController
        vw.Prefix = txtPeca.text!
    }

}

