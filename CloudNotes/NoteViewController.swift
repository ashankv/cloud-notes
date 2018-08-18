//
//  NoteViewController.swift
//  CloudNotes
//
//  Created by Ashank Verma on 7/27/18.
//  Copyright © 2018 Ashank Verma. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import AWSCognito
import AWSS3


class NoteViewController: UIViewController {

    @IBOutlet var titleText: UIView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    let backgroundImage = UIImage(named: "cloud_background.jpg")
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        notes.append(Note(title: titleLabel.text!, body: bodyTextField.text!))
        let txtFileURL = getFileUrlFromUserInput()
        //uploadTextFileToS3(fileURL: txtFileURL)
        
        /* var readString = ""
        
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError{
            print("Failed to read file")
            print(error)
        }
        
        print("CONTENTS OF FILE: \(readString)") */
        
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AWS Managing
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1,
                                                                identityPoolId:"us-east-1:89eb43f8-f578-43b5-b8f5-a1b04eb272b8")
        let configuration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cloud_bg2.jpg")!)
        
        

        //bodyTextField.layer.cornerRadius = 12.0
        //bodyTextField.layer.borderWidth = 2.0
        //bodyTextField.layer.borderColor = UIColor(red:230, green:230, blue:230, alpha:1.0).cgColor
        
        bodyTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        bodyTextField.layer.borderWidth = 1.0
        bodyTextField.layer.cornerRadius = 5
        navigationItem.largeTitleDisplayMode = .never


        // Do any additional setup after loading the view.
    }
    
    func getFileUrlFromUserInput() -> URL{
        
        let fileName = titleLabel.text!
        let docDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = docDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        let bodyString = bodyTextField.text!
        
        do {
            try bodyString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed to write to URL")
            print(error)
        }
      
        return fileURL
    }
    
    func uploadTextFileToS3(fileURL: URL) {
        
        let key = "\(titleLabel.text!).txt"
        let request = AWSS3TransferManagerUploadRequest()!
        request.key = key
        request.bucket = "cloud-notes"
        request.body = getFileUrlFromUserInput()
        request.acl = .publicReadWrite
        
        let transferManager = AWSS3TransferManager.default()

        transferManager.upload(request).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any?
            in
            if let error = task.error {
                print(error)
            }
            
            if task.result != nil {
                print("Uploaded \(key)")
            }
            
            return nil
        }
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
