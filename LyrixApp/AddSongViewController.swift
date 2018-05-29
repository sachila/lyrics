//
//  AddSongViewController.swift
//  LyrixApp
//
//  Created by Disni Sriyaratna on 5/18/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Artist: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var songName: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var lyrics: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var artistValid: Bool = false
    var categoryValid: Bool = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        imagePicker.delegate = self
    }

    @IBAction func loadImages(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    // MARK: - UIImagePickerControllerDelegate Methods
//    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
        if imageView.image != nil{
            songObj.image = UIImagePNGRepresentation(imageView.image!)! as NSData
            
        }
      
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
