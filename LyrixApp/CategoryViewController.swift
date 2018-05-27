//
//  CategoryViewController.swift
//  LyrixApp
//
//  Created by sachila on 5/27/18.
//  Copyright © 2018 Infinity. All rights reserved.
//SeagueSong

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var result: [LCategory] = [];
    var rowId: String?
    
    @IBOutlet weak var tableView: UITableView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if segue.identifier == "seagueSong"{
                let recieve = segue.destination as! SongListViewController
                if self.rowId != nil{
                    recieve.setFromCategory(val: true, id: self.rowId!)
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowId = String(result[indexPath.row].lId )
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (result.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) as! CategoryTableViewCell
        if result.count > 0{
            cell.categoryName.text = result[indexPath.row].lName
        }
        return (cell)
    }

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatgory() 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadCatgory(){
        let context = appDelegate.persistentContainer.viewContext
        result = LCategory.GetAllCategories(context: context)
        for data in result  {
            print(data.lId  )
        }
    }

}
