//
//  Database.swift
//  SQLiteExample
//
//  Created by techmaster on 12/8/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit

class DataBase {
    static let sharedInstance = DataBase()
    
    var dbPath = NSString()
    
    private init() {
        getPath()
    }
    
    func getPath() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = NSString(string: dirPath[0])
        dbPath = docPath.appending("/english.db") as NSString
        print(dbPath)
    }
    
    func createDB() -> Bool {
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath as String) {
            
            let engDB = FMDatabase(path: dbPath as String)
            
            if engDB == nil {
                print("error engDB nil = \(engDB?.lastErrorMessage())")
            }
            
            if (engDB?.open())! {
                let createWordTbl = "create table if not exists WORDS (ID integer primary key autoincrement, word text, mean text, type text, sentence text, vocal text, sound text, image text, synonym text, time integer default(0))"
            
                if !(engDB?.executeStatements(createWordTbl))! {
                    print("Error: \(engDB?.lastErrorMessage())")
                }
                
                if !(engDB?.executeStatements("PRAGMA foreign_keys = ON"))! {
                    print("Error: \(engDB?.lastErrorMessage())")
                }
            }
            else {
                print("error = \(engDB?.lastErrorMessage())")
            }
            engDB?.close()
            return true
        }
        
        return false
    }
    
    func insertDB(_ tbl_name: String,_ data: NSDictionary) {
        
        var keys = String()
        var values = String()
        var isFirst = true
        
        for key in data.allKeys {
            if isFirst {
                keys = "'" + (key as! String) + "'"
                values = "'" + (data.object(forKey: key) as! String) + "'"
                isFirst = false
                continue
            }
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (data.object(forKey: key) as! String) + "'"
        }
        
        let engDB = FMDatabase(path: dbPath as String)
        
        if (engDB?.open())! {
            
            if (engDB?.executeStatements("PRAGMA foreign_keys = ON"))! {
                print("error foreign_keys = \(engDB?.lastErrorMessage())")
            }
            let insertCmd = "INSERT INTO \(tbl_name) (\(keys)) VALUES (\(values))"
            
            let result = engDB?.executeUpdate(insertCmd, withArgumentsIn: nil)
            
            if !result! {
                print("error result = \(engDB?.lastErrorMessage())")
            }
        }
        engDB?.close()
        
    }
    
    func deleteDB(_ tbl_name: String,_ ID : Int) {
        
        let engDB = FMDatabase(path: dbPath as String)
        
        if (engDB?.open())! {
            
            if !(engDB?.executeStatements("PRAGMA foreign_keys = ON"))! {
                print("Error: \(engDB?.lastErrorMessage())")
            }
            
            let deleteCmd = "DELETE FROM \(tbl_name) WHERE ID = \(ID)"
            
            let result = engDB?.executeUpdate(deleteCmd, withArgumentsIn: nil)
            
            if !result! {
                print("Error : \(engDB?.lastErrorMessage())")
            }
        }
        engDB?.close()
    }
    
    func updateDB(_ tbl_name: String,_ data: NSDictionary,_ ID : Int ) {
        
        var paramsUpdateStr = String()
        var isFirst = true
        for key in data.allKeys {
            if isFirst {
                paramsUpdateStr = "'" + (key as! String) + "'" + "=" + "'" + (data.object(forKey: key) as! String) + "'"
                isFirst = false
                continue
            }
            paramsUpdateStr =  paramsUpdateStr + "," + "'" + (key as! String) + "'" + "=" + "'" + (data.object(forKey: key) as! String) + "'"

        }
        
        let engDB = FMDatabase(path: dbPath as String)
        
        if (engDB?.open())! {
            if (engDB?.executeStatements("PRAGMA foreign_keys = ON"))! {
                print("error = \(engDB?.lastErrorMessage())")
            }
            
            let updateCmd = "UPDATE \(tbl_name) SET \(paramsUpdateStr) WHERE ID = \(ID)"
            
            let result = engDB?.executeUpdate(updateCmd, withArgumentsIn: nil)
            
            if !result! {
                print("error = \(engDB?.lastErrorMessage())")
            }
        }
        engDB?.close()
        
    }
    
    func viewDB(_ tbl_name: String,_ columns: [String],_ statement: String) -> [NSDictionary] {
        
        var allColumns = ""
        var items = [NSDictionary]()
        for column in columns {
            if (allColumns == "") {
                allColumns = column
            }
            else {
                allColumns = allColumns + "," + column
                
            }
        }
        let selectCmd = "Select  \(allColumns) From \(tbl_name) \(statement)"
        
        let englishDB = FMDatabase(path: dbPath as String)
        
        if (englishDB?.open())! {
            let results: FMResultSet? = englishDB?.executeQuery(selectCmd, withArgumentsIn: nil)
            
            while ((results?.next()) == true) {
                items.append(results!.resultDictionary() as NSDictionary)
            }
        }
        englishDB?.close()
        return items
    }
    
}
