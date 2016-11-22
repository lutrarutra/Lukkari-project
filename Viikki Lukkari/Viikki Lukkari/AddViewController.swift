//
//  AddViewController.swift
//  Viikki Lukkari
//
//  Created by lutrarutra on 17/11/16.
//  Copyright © 2016 lutrarutra. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var coursePickerTool: UIPickerView!
    @IBOutlet weak var outputForCourses: UITableView!
    
    private var tempSelectedCourses = [String]()
    
    var array1 = [String]()
    var array2 = [String]()
    var array3 = [String]()
    private var curPresentedArray = [String]()
    private var currentHolder: Int?
    private var selectedGrade = Grade.eka
    
    
    //Alert to name your lukkari what ever you want (default is Untitled)
    var alert = UIAlertController(title: "Final Step", message: "Name your new lukkari", preferredStyle: UIAlertControllerStyle.alert)
    
    enum Grade {
        case abi
        case eka
        case toka
        case none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursePickerTool.delegate = self
        coursePickerTool.dataSource = self
        currentHolder = 0
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = "Untitled (\(data.allLukkarit.count + 1))"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = self.alert.textFields![0] as UITextField
            data.allLukkarit[textField.text!] = self.tempSelectedCourses
            data.save()
            
            self.navigationController?.popToRootViewController(animated: true)
            if data.allLukkarit.count == 1 {
                data.mainPeriod = data.tempPeriod
                data.changeMainLukkari(s: textField.text!)
            }
            
            //print(Array(data.allLukkarit.keys))
            
        }))
    }
    
    override func viewWillAppear(_ animated: Bool){
        var filename = "file1" + String(data.tempPeriod)
        if IO.readFromFile(filename: filename){
            for line in (data.file?.components(separatedBy: .newlines))!{
                if line.contains("$") || array1.contains(line) || line.isEmpty{
                    
                } else {
                    array1.append(line)
                }
            }
        }
        filename = "file2" + String(data.tempPeriod)
        if IO.readFromFile(filename: filename){
            for line in (data.file?.components(separatedBy: .newlines))!{
                if line.contains("$") || array2.contains(line) || line.isEmpty{
                    
                } else {
                    array2.append(line)
                }
            }
        }
        filename = "file3" + String(data.tempPeriod)
        if IO.readFromFile(filename: filename){
            for line in (data.file?.components(separatedBy: .newlines))!{
                if line.contains("$") || array3.contains(line) || line.isEmpty {
                    
                } else {
                    array3.append(line)
                }
            }
        }
        curPresentedArray = array1
        coursePickerTool.reloadAllComponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentHolder = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Return current selected value
        return curPresentedArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Return the size of an array that will be in the picker
        return curPresentedArray.count
    }

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSelectedCourses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Test")
        cell.textLabel?.text = tempSelectedCourses[(indexPath as NSIndexPath).row]
        return cell
    }
    
    
    @IBAction func gradeChanged(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            curPresentedArray = array1
            selectedGrade = .eka
            break
        case 1:
            curPresentedArray = array2
            selectedGrade = .toka
            break
        case 2:
            curPresentedArray = array3
            selectedGrade = .abi
            break
        default:
            break
        }
        coursePickerTool.reloadAllComponents()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            tempSelectedCourses.remove(at: (indexPath as NSIndexPath).row)
            outputForCourses.reloadData()
        }
    }
    
    
    @IBAction func addCourse(_ sender: UIButton) {
        if !tempSelectedCourses.contains(curPresentedArray[currentHolder!]){
            tempSelectedCourses.append(curPresentedArray[currentHolder!])
            outputForCourses.reloadData()
        }
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
