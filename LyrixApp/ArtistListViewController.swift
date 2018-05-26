//
//  ArtistListViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/9/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class ArtistListViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   

    @IBOutlet weak var searchArtist: UISearchBar!
    @IBOutlet weak var lstArtistList: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var result: [LArtist] = []
    var rowId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtist();
        searchArtist.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if segue.identifier == "seague"{
                /*let recieve = segue.destination as! ArtistDetailsViewController
                if self.rowId != nil{
                    recieve.loadById(id: self.rowId!)
                }*/
            }
        })
    }
    
    func loadArtist(){
        
        let context = appDelegate.persistentContainer.viewContext
        let result = LArtist.GetAllArtists(context: context)
        for data in result  {
            print(data.lName)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowId = String(result[indexPath.row].lId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (result.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! ArtistsTableViewCell
        if result.count > 0{
            cell.artistsName.text = result[indexPath.row].lName
            if result[indexPath.row].lImage != nil{
                cell.artistsImage?.image = UIImage(data:result[indexPath.row].lImage! as Data,scale:1.0)
            }
        }
        return (cell)
    }
    
    func removeArtist(){
        let context = appDelegate.persistentContainer.viewContext
        let result = LArtist.RemoveArtistById(id: "2", context: context)
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
