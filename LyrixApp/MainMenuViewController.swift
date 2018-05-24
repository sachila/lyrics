//
//  MainMenuViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var btnAddArtist: UIButton!
    @IBOutlet weak var btnArtistList: UIButton!
    @IBOutlet weak var btnAddSong: UIButton!
    @IBOutlet weak var btnSongList: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let context = appDelegate.persistentContainer.viewContext
        LCategory.SetDefaultValues(context: context)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
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
