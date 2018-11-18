//
//  DataManager.swift
//  SQLite Database
//
//  Created by Win Than Htike on 11/18/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import Foundation
import FMDB

class DataManager {
    
    let databaseFileName = "todo.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    static let shared: DataManager = DataManager()
    
    init() {
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        let created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                
                if database.open() {
                    
                    createTodoTable()
                    database.close()
                    
                }else{
                    
                    print("Could not open the database.")
                    
                }
                
            }
            
        }
        
        return created
    }

    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func performCreateTableExec(query : String){
        
        do {
            try database.executeUpdate(query, values: nil)
        } catch {
            print("Could not create table.")
            print(error.localizedDescription)
        }
        
    }
    
    func performInsertExec(query : String) {
        
        if !database.executeStatements(query) {
            print("Failed to insert initial data into the database.")
            print(database.lastError(), database.lastErrorMessage())
        }
        
        database.close()
        
    }
    
    func createTodoTable() {
        
        let createSingerTableQuery = "create table todos (id integer primary key not null, name text not null)"
        
        performCreateTableExec(query: createSingerTableQuery)
        
    }
    
    func insertTask(taskName : String) {
        
        if openDatabase() {
            
            let taskInsertQuery = "insert into todos ('name') values ('\(taskName)')"
            
            performInsertExec(query: taskInsertQuery)
            
        }
        
    }
    
    func getTodoList() -> [TodoVO] {
        
        var taskList = [TodoVO]()
        
        if openDatabase() {
            
            let query = "select * from todos"
            
            do {
                
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    
                    let task = TodoVO()
                    task.name = results.string(forColumn: "name") ?? "Unknow"
                    task.id = Int(results.int(forColumn: "id"))
                    taskList.append(task)
                    
                }
                
            }catch {
                print(error.localizedDescription)
            }
            
            database.close()
            
        }
        
        return taskList
        
    }
    
    func updateTask(taskName : String, id : Int) {
        
        if openDatabase() {
        
            let query = "update todos set name =? where id =?"
            
            do {
                try database.executeUpdate(query, values: [taskName, id])
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    func deleteTaskList() {
        
        if openDatabase() {
            
            let query = "delete from todos"
            
            do {
                try database.executeUpdate(query, values: nil)
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
            
        }
        
    }
    
    
}
