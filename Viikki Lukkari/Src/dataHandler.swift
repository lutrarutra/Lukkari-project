//
//  dataHandler.swift
//  Viikki Lukkari
//
//  Created by lutrarutra on 17/11/16.
//  Copyright © 2016 lutrarutra. All rights reserved.
//

import Foundation

let data = dataHandler()

class dataHandler {
    
    var selectedPeriod = 1
    var mainLukkari: String?
    var allLukkarit: Dictionary<String, Array<String>> = [:]
    var sortedViewArray = [[[String]]](repeating: [[String]] (repeating: [], count:5), count:5)
    var file: String?
    var tempPeriod = 1
    var mainPeriod = 3
    let defaults = UserDefaults.standard
    var edited = false
    
    func makeSaveableString(a: [String], t: Bool) -> String{
        var temp = ""
        for obj in a{
            temp += obj + ";"
        }
        if t {
            temp += "$"
        }
        return temp
    }
    
    
    func changeMainLukkari(s: String){
        mainLukkari = s
        defaults.setValue(s, forKey: defaultKeys.mainLukkari)
        defaults.synchronize()
        edited = true
    }
    
    
    func save(){
        
        defaults.set(makeSaveableString(a: Array(allLukkarit.keys), t: false), forKey: defaultKeys.keys4Lukkarit)
        var tempA = ""
        for array in allLukkarit.values{
            tempA += makeSaveableString(a: array, t: true)
            
        }
        defaults.set(tempA, forKey: defaultKeys.allLukkarit)
        print(tempA)
        defaults.synchronize()
        
    }
    
    func load() -> Bool{
        //Get main lukkari from default and set it
        if let main = defaults.string(forKey: defaultKeys.mainLukkari) {
            mainLukkari = main
        } else {
            return false
        }
        
        //Get keys and all lukkarit from defaults and set them up
        if let lukkarit = defaults.string(forKey: defaultKeys.allLukkarit){
            if let keys = defaults.string(forKey: defaultKeys.keys4Lukkarit){
                print(keys)
                var i = 0
                for key in keys.components(separatedBy: ";"){
                    allLukkarit[key] = lukkarit.components(separatedBy: "$")[i].components(separatedBy: ";")
                    i += 1
                }
                
            } else{
                return false
            }
        } else {
            return false
        }
        edited = true
        return true
    }
    
    func delete(k: String){
        //Find key from keylist and delete
        allLukkarit.removeValue(forKey: k)
        if mainLukkari! == k {
            mainLukkari = nil
            defaults.setValue(nil, forKey: defaultKeys.mainLukkari)
        }
        edited = true
        save()
        load()
    }
    
    
    
    
}

struct defaultKeys {
    static let mainLukkari = "mainLukkari"
    static let allLukkarit = "allLukkari"
    static let keys4Lukkarit = "keys4Lukkarit"
}
