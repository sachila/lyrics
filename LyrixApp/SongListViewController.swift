//
//  SongListViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var result: [LSongs] = [];
    @IBOutlet weak var songTable: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (result.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! SongsTableViewCell
        cell.songName.text = result[indexPath.row].lName
        return (cell)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSongs()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSongs(){
        
        let context = appDelegate.persistentContainer.viewContext
        result = LSongs.GetAllSongs(context: context)
        for data in result  {
            print(data.lName)
        } 
    }
    
    func removeSong(){
        
        let context = appDelegate.persistentContainer.viewContext
        let result = LSongs.RemoveSongtById(id: "3", context: context)
        if result {
            print("delete success")
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
