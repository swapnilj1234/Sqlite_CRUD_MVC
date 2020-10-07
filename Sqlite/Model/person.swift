//
//  person.swift
//  Sqlite
//
//  Created by swapnil jadhav on 07/10/20.
//  Copyright © 2020 t. All rights reserved.
//

import Foundation

class Person
{
    
    var id : Int = 0
    var name : String = ""
    var age : Int = 0
    
    init(id:Int,name:String,age:Int) {
        self.id = id
        self.name = name
        self.age = age
        
    }
}
