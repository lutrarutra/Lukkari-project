//
//  EditViewController.swift
//  Viikki Lukkari
//
//  Created by lutrarutra on 17/11/16.
//  Copyright © 2016 lutrarutra. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var lukkaritList: UITableView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lukkaritList.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lukkaritList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePeriod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            data.tempPeriod = 1
            break
        case 1:
            data.tempPeriod = 2
            break
        case 2:
            data.tempPeriod = 3
            break
        case 3:
            data.tempPeriod = 4
            break
        case 4:
            data.tempPeriod = 5
            break
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.allLukkarit.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Test")
        var a = [String](data.allLukkarit.keys)
        cell.textLabel?.text = a[(indexPath as NSIndexPath).row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            var a = [String](data.allLukkarit.keys)
            data.delete(k: a[(indexPath as NSIndexPath).row])
            self.lukkaritList.reloadData()
        }
        
        let share = UITableViewRowAction(style: .normal, title: "Default") { (action, indexPath) in
            var a = [String](data.allLukkarit.keys)
            data.changeMainLukkari(s: a[(indexPath as NSIndexPath).row])
            self.lukkaritList.reloadData()
        }
        
        share.backgroundColor = button.tintColor
        return [delete, share]
    }
    
}
