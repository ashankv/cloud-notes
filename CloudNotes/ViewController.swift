//
//  ViewController.swift
//  CloudNotes
//
//  Created by Ashank Verma on 7/20/18.
//  Copyright © 2018 Ashank Verma. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var testNote = Note(title:"Test", body:"Hello World!")
    var notes = [Any]()
    
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        notes.append(testNote)
        notes.append(testNote)
        notes.append(testNote)
        notes.append(testNote)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        editButtonItem.tintColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)
        navigationItem.leftBarButtonItem = editButtonItem
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(insertNewObject(_:)))
        //addButton.tintColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)
        //navigationItem.rightBarButtonItem = addButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        notes.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let note = notes[indexPath.row] as! Note
                let controller = (segue.destination) as! DetailViewController
                
                controller.detailItem = note
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
        
            }
        }
        
        
    }
    
    // Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.row] as! Note
        cell.textLabel!.text = note.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

