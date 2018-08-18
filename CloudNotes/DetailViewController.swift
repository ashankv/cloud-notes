//
//  DetailViewController.swift
//  CloudNotes
//
//  Created by Ashank Verma on 7/20/18.
//  Copyright © 2018 Ashank Verma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailBodyLabel: UITextView!
    
    let backgroundImage = UIImage(named: "cloud_background.jpg")
    
    func configureView() {
        // Update the user interface for the detail item.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cloud_bg2.jpg")!)
        
        if let detail = detailItem {
            if let label = detailDescriptionLabel, let body = detailBodyLabel {
                label.text = detail.title
                body.text = detail.body
            }
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "";

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: Note? {
        didSet {
            // Update the view.
            configureView()
        }
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
