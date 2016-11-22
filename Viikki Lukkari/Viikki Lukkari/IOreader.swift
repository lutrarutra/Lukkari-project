//
//  IOreader.swift
//  Viikki Lukkari
//
//  Created by lutrarutra on 17/11/16.
//  Copyright © 2016 lutrarutra. All rights reserved.
//

import Foundation

let IO = IOreader()

class IOreader{
    func readFromFile(filename: String) -> Bool {
        var textFromFile: String?
        if let path = Bundle.main.path(forResource: filename, ofType: "txt"){
            do {
                let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as String
                textFromFile = contents
            } catch {
                print("error")
            }
        }
        
        if textFromFile != nil{
            data.file = textFromFile
            return true
        }else {
            print("Error")
            return false
        }
        

    }
}
