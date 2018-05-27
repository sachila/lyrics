//
//  SongListViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var songTable: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var result: [LSongs] = [];
    var rowId: String?
    
    var fromCategory: Bool = false
    var categoryId: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if segue.identifier == "seague"{
                let recieve = segue.destination as! SongDetailsViewController
                if self.rowId != nil{
                    recieve.loadById(id: self.rowId!)
                }
            }
        })
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText != "" {
            let context = appDelegate.persistentContainer.viewContext
            result = LSongs.QuerySongsByName(name: searchText, context: context)
        }else{
            loadSongs()
        } 
        songTable.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowId = String(result[indexPath.row].lId )
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (result.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! SongsTableViewCell
        if result.count > 0{
            cell.songName.text = result[indexPath.row].lName
            if result[indexPath.row].limage != nil{
                cell.imageView?.image = UIImage(data:result[indexPath.row].limage! as Data,scale:1.0)
            }
        }
        return (cell)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSongs()
        searchBar.delegate = self
    }
    
    func setFromCategory(val: Bool, id: String){
        self.fromCategory = val
        self.categoryId = id
        loadSongs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSongs(){
        if !fromCategory{
            let context = appDelegate.persistentContainer.viewContext
            result = LSongs.GetAllSongs(context: context)
            for data in result  {
                print(data.lId  )
            }
        }else{
            let context = appDelegate.persistentContainer.viewContext
            result = LSongs.GetSongsByCategoryId(id: categoryId, context: context)
            for data in result  {
                print(data.lName )
            }
            songTable.reloadData()
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
