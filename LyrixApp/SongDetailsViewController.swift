//
//  SongDetailsViewController.swift
//  LyrixApp
//
//  Created by sachila on 5/25/18.
//  Copyright © 2018 Infinity. All rights reserved.
//

import UIKit

class SongDetailsViewController: UIViewController {

    var id: String?
    @IBOutlet weak var songLyrics: UITextView!
    @IBOutlet weak var songTitle: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        songLyrics.isEditable = false
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageView: UIImageView!
    func loadById(id:String) -> Void {
        self.id = id
        let context = appDelegate.persistentContainer.viewContext
        let result = LSongs.GetAllSongsID(id: self.id!, context: context)
        if result != nil{
            songLyrics.text = result.lLyrics
            songTitle.text = result.lName
            if result.limage != nil{
                imageView.image =  UIImage(data:result.limage! as Data,scale:1.0)
            }
        }
    }
 

}
