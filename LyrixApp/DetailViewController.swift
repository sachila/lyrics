//
//  DetailViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/9/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBAction func btnStart(_ sender: UIButton) {
        
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.timestamp.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: UIEvent? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

