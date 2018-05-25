//
//  ArtistListViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/9/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class ArtistListViewController: UIViewController {

    @IBOutlet weak var searchArtist: UISearchBar!
    @IBOutlet weak var lstArtistList: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtist();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadArtist(){
        
        let context = appDelegate.persistentContainer.viewContext
        let result = LArtist.GetAllArtists(context: context)
//        for data in result  {
//            print(data.lName)
//        }
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
