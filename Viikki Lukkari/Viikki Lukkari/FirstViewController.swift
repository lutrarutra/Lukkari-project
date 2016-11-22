//
//  FirstViewController.swift
//  Viikki Lukkari
//
//  Created by lutrarutra on 17/11/16.
//  Copyright © 2016 lutrarutra. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var gridView: UICollectionView!
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    let reuseIdentifier = "cell"
    var items = [String](repeating: "-", count: 25)
    let ratio = [0,5,10,15,20,1,6,11,16,21,2,7,12,17,22,3,8,13,18,23,4,9,14,19,24]
    fileprivate let itemsPerRow: CGFloat = 5
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 2.0, bottom: 50.0, right: 2.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        gridView.dataSource = self
        gridView.delegate = self
        
        print(data.load())
        //print(data.allLukkarit)
        
        if data.mainLukkari != nil{
            if !data.mainLukkari!.isEmpty {
                updateCellView()
            }
        }
        
        gridView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if data.mainLukkari != nil && data.edited {
            items = [String](repeating: "-", count: 25)
            updateCellView()
            data.edited = false
            print("lol")
        }
        else if data.edited {
            items = [String](repeating: "-", count: 25)
            data.edited = false
            print("ha")
        }
        gridView.reloadData()
    }
    

    
    private func updateCellView(){
        var i = 0
        var tempA = [String]()
        
        tempA = [String]()
        if IO.readFromFile(filename: "file1" + String(data.mainPeriod)){
            tempA = (data.file?.components(separatedBy: "$"))!
        }
        
        while i < 25 {
            
            for obj in tempA[i].components(separatedBy: .newlines){
                if !obj.isEmpty{
                    for course in data.allLukkarit[data.mainLukkari!]!{
                        if makeString(str: obj) == makeString(str: course){
                            items[ratio[i]] = makeString(str: obj)
                        }
                    }
                }
            }
            
            i += 1
        }
        
        
        i = 0
        tempA = [String]()
        if IO.readFromFile(filename: "file2" + String(data.mainPeriod)){
            tempA = (data.file?.components(separatedBy: "$"))!
        }
        
        while i < 25 {
            
            for obj in tempA[i].components(separatedBy: .newlines){
                if !obj.isEmpty{
                    for course in data.allLukkarit[data.mainLukkari!]!{
                        if makeString(str: obj) == makeString(str: course){
                            items[ratio[i]] = makeString(str: obj)
                        }
                    }
                }
            }
            
            i += 1
        }
        
        tempA = [String]()
        if IO.readFromFile(filename: "file3" + String(data.mainPeriod)){
            tempA = (data.file?.components(separatedBy: "$"))!
        }
        
        i = 0
        
        while i < 25 {
            
            for obj in tempA[i].components(separatedBy: .newlines){
                if !obj.isEmpty{
                    for course in data.allLukkarit[data.mainLukkari!]!{
                        if makeString(str: obj) == makeString(str: course){
                            items[ratio[i]] = makeString(str: obj)
                        }
                    }
                }
            }
            
            i += 1
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.myLabel.numberOfLines = 1
        cell.myLabel.adjustsFontSizeToFitWidth = true
        cell.myLabel.minimumScaleFactor = 0.1
        cell.backgroundColor  = self.view.tintColor
        cell.myLabel.textColor = UIColor.white
        cell.myLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.myLabel.textAlignment = .center
        
        return cell
    }
    
    private func makeString(str: String) -> String{
        
        return str.components(separatedBy: .whitespaces)[0]
        
    }

}

extension FirstViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

