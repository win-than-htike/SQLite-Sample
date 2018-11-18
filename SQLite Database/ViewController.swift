//
//  ViewController.swift
//  SQLite Database
//
//  Created by Win Than Htike on 11/18/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("Mg Mg", forKey: "name")
        
        UserDefaults.standard.string(forKey: "name")
        
    }


}

