//
//  AddArtistViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit
import CoreData

class AddArtistViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
    override func viewDidLoad() {
        super.viewDidLoad()
        saveArtist()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveArtist() {
        let context = appDelegate.persistentContainer.viewContext
        let res = LArtist.SaveArtists(name: "sample1", context: context)
        if res {
            print("success")
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
