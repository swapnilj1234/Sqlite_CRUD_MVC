//
//  ViewController.swift
//  Sqlite
//
//  Created by swapnil jadhav on 06/10/20.
//  Copyright © 2020 t. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [Person]()
    
    var opens = DBHelper()
    
    var UpdateTag : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        opens.openDatabase()
        //opens.createtable()
        nameArray = opens.read()
        
        
    }

    @IBAction func AddNameButton(_ sender: UIBarButtonItem) {
        
        
       var textField = UITextField()
       var nameText = UITextField()
       var ageText = UITextField()
        
        let alert = UIAlertController(title: "Add Name", message: "Enter Name", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        
            
            
        
            let ids = Int(textField.text!)
            let name = nameText.text
            let age = Int(ageText.text!)
           
            
            self.opens.insert(id: ids!, name: name!, age: age!)
            
            
            
             self.nameArray = self.opens.read()
             self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (IdText) in
            
            
            IdText.placeholder = "Enter id"
            
            textField = IdText
        }
        alert.addTextField { (alertname) in
            
            alertname.placeholder = "enter name"
            
            nameText = alertname
        }
        alert.addTextField { (alertage) in
            alertage.placeholder = "enter age"
            
            ageText = alertage
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let UpdateView = UpdateViewController()
//
//        UpdateView.name =
//        UpdateView.age =
    }
    
    
    @objc func UpdateData(sender:UIButton)
    {
        
        
        var update = storyboard?.instantiateViewController(identifier: "UpdateView") as! UpdateViewController
        
        update.name = nameArray[sender.tag].name
        update.age = Int(nameArray[sender.tag].age)
        update.id = Int(nameArray[sender.tag].id)
        self.navigationController?.pushViewController(update, animated: true)
        
        
    }
    
    @objc func deleteData(sender:UIButton)
    {
        
        var deleteId = nameArray[sender.tag].id
        
        
        opens.DeleteById(Id: deleteId)
        
       
        nameArray = opens.read()
        self.tableView.reloadData()
    
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        nameArray = opens.read()
        
        tableView.reloadData()
    }
    
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.nameLbl.text = "name:\(nameArray[indexPath.row].name)"
        
        cell.idLbl.text = "id :\(nameArray[indexPath.row].id)"
        
        cell.ageLbl.text = "age: \(nameArray[indexPath.row].age)"
        
        cell.updateButton.addTarget(self, action: #selector(UpdateData(sender:)), for: .touchUpInside)
        
        cell.deleteButton.addTarget(self, action: #selector(deleteData(sender:)), for: .touchUpInside)
    
        cell.updateButton.tag = indexPath.row
        
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
}

