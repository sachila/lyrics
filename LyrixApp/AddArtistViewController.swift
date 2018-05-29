//
//  AddArtistViewController.swift
//  LyrixApp
//
//  Created by Disni Sriyaratna on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit
import CoreData

class AddArtistViewController: UIViewController {

    @IBOutlet weak var artistName: UITextField!
    
    @IBOutlet weak var artistImage: UIImageView!
    let imagePicker = UIImagePickerController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
  
    override func viewDidLoad() {
        super.viewDidLoad()
       // saveArtist()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnAddSongClick(_ sender: UIButton) {
        saveArtist()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveArtist() {
        let context = appDelegate.persistentContainer.viewContext
        
        let artistObj =  artists();
        artistObj.artistName = artistName.text!
        if artistImage.image != nil{
            artistObj.artistImage = UIImagePNGRepresentation(artistImage.image!)! as NSData
            
        }
        
        let res = LArtist.SaveArtists(artist: artistObj, context: context)
        
        if res {
            let refreshAlert = UIAlertController(title: "Saved", message: "successfully save the artist", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.reset()
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
   }
    
    
    func reset(){
        artistName.text = ""
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
