//
//  NoteViewController.swift
//  CloudNotes
//
//  Created by Ashank Verma on 7/27/18.
//  Copyright © 2018 Ashank Verma. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet var titleText: UIView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    let backgroundImage = UIImage(named: "cloud_background.jpg")
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        notes.append(Note(title:titleLabel.text!, body:bodyTextField.text!))
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cloud_background.jpg")!)

        //bodyTextField.layer.cornerRadius = 12.0
        //bodyTextField.layer.borderWidth = 2.0
        //bodyTextField.layer.borderColor = UIColor(red:230, green:230, blue:230, alpha:1.0).cgColor
        
        bodyTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        bodyTextField.layer.borderWidth = 1.0
        bodyTextField.layer.cornerRadius = 5
        navigationItem.largeTitleDisplayMode = .never


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
