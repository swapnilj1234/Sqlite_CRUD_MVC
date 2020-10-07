//
//  DBHelper.swift
//  Sqlite
//
//  Created by swapnil jadhav on 06/10/20.
//  Copyright © 2020 t. All rights reserved.
//

import Foundation
import SQLite3



class DBHelper
{
    init() {
        
        db = openDatabase()
        createtable()
        
    }
    
    let dbpath : String = "Student.sqlite"
    var db : OpaquePointer?
    
    let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    
    
    func openDatabase() -> OpaquePointer?
    {
        
        let databasePath = fileUrl.appendingPathComponent(dbpath)

       
        
        print(fileUrl)
        
        var db  : OpaquePointer?
        
        
        if sqlite3_open(databasePath.path,&db) != SQLITE_OK
        {
            print("error opening database")
            
            return nil
        }
        
        else
        {
            print("successfully open connection")
            return db
        }
    }
    
    func createtable()
    {
        let query = "CREATE TABLE  person(Id INTEGER(20) PRIMARY KEY,name varchar(30),age INTEGER)"
        
        var pointerStatement : OpaquePointer? = nil
        
        let databasePath = fileUrl.appendingPathComponent(dbpath)

        
        if sqlite3_open(databasePath.path, &pointerStatement) == SQLITE_OK
        {
        
            if sqlite3_exec(pointerStatement, query, nil, nil, nil) == SQLITE_OK
           {
             print("table created")
         
           }
            else
            
            {
                print("table not create or already exists")
            }
        }
        else
        {
            
            print("Database not open\(Error.self)")
        }
            
        
        sqlite3_close(pointerStatement)
    }
    
    
    func read() -> [Person]
    {
        
        let query = "select * from person order by Id"
        
        var pointer : OpaquePointer?
        
        var psns : [Person] = []
        
        var databasepath = fileUrl.appendingPathComponent(dbpath)
        
        if sqlite3_open(databasepath.path, &db) == SQLITE_OK
        
        {
        
             if sqlite3_prepare(db, query, -1, &pointer, nil) == SQLITE_OK
           {
            while sqlite3_step(pointer) == SQLITE_ROW {
                let id =  sqlite3_column_int(pointer, 0)
                let name = String.init(format: "%s", sqlite3_column_text(pointer, 1))
                let age = sqlite3_column_int(pointer, 2)
                
                
                psns.append(Person(id: Int(id), name: name, age: Int(age)))
                
               
                
                print("query result")
                print("\(id) | \(name) | \(age)")
            }
        }
        else
        {
            print("select statement could not prepared")
        }
        }
        else
        {
            print("databse not open")
        }
        
        return psns
    }
    
    func insert(id:Int,name:String,age:Int)
    {
        
        let person = read()
        
        for p in person
        {
            if p.id == id
            {
            return
                
            }
        }
        
        let query = "insert into person (Id,name,age) values (?,?,?)"
        
        var pointer : OpaquePointer? = nil
        
       
        if sqlite3_prepare(db, query, -1, &pointer, nil) == SQLITE_OK
        {
            
            sqlite3_bind_int(pointer, 1, Int32(id))
            sqlite3_bind_text(pointer, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(pointer, 3, Int32(age))
            
            
            if sqlite3_step(pointer) == SQLITE_DONE
            {
                print("successfully insert")
            }
            else
            {
                print("not insert")
            }

            
        }
        else
        {
            print("insert not prepare")
        }
        
        sqlite3_finalize(pointer)
        
    }
    
    func DeleteById(Id:Int)
    {
        
        var query = "Delete from person where id = ?"
        
        var pointer : OpaquePointer? = nil
        
        if sqlite3_prepare(db, query, -1, &pointer,nil) == SQLITE_OK
        
        {
            sqlite3_bind_int(pointer, 1, Int32(Id))
            
            if sqlite3_step(pointer) ==  SQLITE_DONE
            {
                print("delete row Successfully")
            }
            
            else
            {
                print("no delete row")
            }
        }
        
        else
        {
            print("delete statement not prepare")
        }
        
        sqlite3_finalize(pointer)
        
    }
    
    
    func update(id:Int,name:String,age:Int)
    {
        
        var pointer : OpaquePointer? = nil
        
        var query = "Update person set name = ? , age = ? where id = ? "
        
        if sqlite3_prepare(db, query, -1, &pointer, nil) == SQLITE_OK
        {
             sqlite3_bind_text(pointer, 1, (name as NSString).utf8String, -1, nil)
             sqlite3_bind_int(pointer, 2, Int32(age))
             sqlite3_bind_int(pointer, 3, Int32(id))
             
            
            if sqlite3_step(pointer) == SQLITE_DONE
            {
                print("Updated")
            }
            else
            {
                print("Update error")
            }
            
            
        }
        else
        {
            print("update not prepare")
        }
        sqlite3_finalize(pointer)
        
    }
}
