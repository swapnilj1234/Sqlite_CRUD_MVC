//
//  UpdateViewController.swift
//  Sqlite
//
//  Created by swapnil jadhav on 07/10/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var UpdateBtn: UIButton!
    
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
  var openDb = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
        nameText.text = name
        ageText.text = "\(age)"
        
        UpdateBtn.layer.cornerRadius = 10.0
    }
    
    @IBAction func Update(_ sender: UIButton) {
        
        
        openDb.update(id: id, name: nameText.text!, age: Int(ageText.text!)!)
        
        
        var Home = storyboard?.instantiateViewController(identifier: "Home") as! ViewController
        self.navigationController?.pushViewController(Home, animated: true)
        
        
        
    }
    
  

}
