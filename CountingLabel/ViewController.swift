//
//  ViewController.swift
//  CountingLabel
//
//  Created by Local on 07/09/2018.
//  Copyright © 2018 Local. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countingLabel: CountingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func pressMe(_ sender: Any) {
        countingLabel.count(fromValue: 0, to: 40, withDuration: 3, andAnimationType: .EaseInOut, andCounterType: .Int)
    }

}

