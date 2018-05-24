//
//  AddSongViewController.swift
//  LyrixApp
//
//  Created by Chintaka Wijetunga on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController {

    @IBOutlet weak var Artist: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var songName: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var lyrics: UITextView!
    
    var artistValid: Bool = false
    var categoryValid: Bool = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
 
    }

    @IBAction func checkArtist(_ sender: Any) {
        
        let context = appDelegate.persistentContainer.viewContext
        let artists = LArtist.SearchArtistsByName(name: Artist.text!, context: context)
        if artists.count == 0{
            let refreshAlert = UIAlertController(title: "Invalid Artist", message: "Artist is not in the list. Please add a new artist", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.Artist.text = ""
            }))
            present(refreshAlert, animated: true, completion: nil)
            artistValid = false
        }else{
            artistValid = true
        }
    }
    @IBAction func categoryCheck(_ sender: UITextField) {
        let context = appDelegate.persistentContainer.viewContext
        let category = LCategory.SearchCategoryByName(name: self.category.text!, context: context)
        if category.count == 0{
            let refreshAlert = UIAlertController(title: "Invalid category", message: "category is not in the list. Please select a vaid category", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.category.text = ""
            }))
            present(refreshAlert, animated: true, completion: nil)
            categoryValid = false
        }else{
            categoryValid = true
        }
    }
    @IBAction func saveSongs(_ sender: UIButton) {
        
        if !categoryValid || !artistValid {
            let refreshAlert = UIAlertController(title: "Invalid", message: "Please enter valid category or artist", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let songObj =  songs();
        songObj.name = songName.text!
        songObj.lyrics = lyrics.text!
        songObj.url = url.text!
        songObj.artistName = Artist.text!
        songObj.categoryName = category.text!
        
        let res = LSongs.SaveSong(song: songObj, context: context)
        if res {
            let refreshAlert = UIAlertController(title: "Saved", message: "successfully save the song", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.reset()
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCategory(){ 
        let context = appDelegate.persistentContainer.viewContext
        let result = LCategory.GetAllCategories(context: context)
        for data in result  {
            print(data.lId)
        }
    }
    
    func reset(){
        songName.text = ""
        url.text = ""
        lyrics.text = ""
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
