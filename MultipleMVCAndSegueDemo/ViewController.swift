//
//  ViewController.swift
//  MultipleMVCAndSegueDemo
//
//  Created by iMac on 1/18/17.
//  Copyright © 2017 Dycode. All rights reserved.
//

import UIKit

let kPhotoDidChangeNotification = "kPhotoDidChangeNotification"

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var photoLinkTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: Selector(("tap:")))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        if let uPhoto = photo{
            idTextField.isEnabled = false
            
            idTextField.text = String(describing: uPhoto.photoId!)
            usernameTextField.text = uPhoto.username
            photoLinkTextField.text = uPhoto.photoLink
        } else{
            deleteButton.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteTapped(sender: UIButton){
        if let uPhoto = photo{
            let deleteAlert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
            deleteAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.managedObjectContext.delete(uPhoto)
                appDelegate.saveContext()
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: kPhotoDidChangeNotification), object: nil, userInfo: nil)
                self.navigationController?.popViewController(animated: true)
            }))
            present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer){
        if sender.state == .ended{
            view.endEditing(true)
        }
    }

    @IBAction func saveTapped(_ sender: Any) {
        guard let id = idTextField.text, let username = usernameTextField.text, let link = photoLinkTextField.text, id.characters.count > 0 else{
            
            let alert = UIAlertController(title: "Warning", message: "ID harus terisi", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let data: [String: Any] = [
            "id" : NSNumber(value: Int(id)!),
            "username" : username,
            "photoLink" : link
        ]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        _ = Photo.photoWithData(data, inManagedObjectContext: moc)
        appDelegate.saveContext()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: kPhotoDidChangeNotification), object: nil, userInfo: nil)
        
        navigationController?.popViewController(animated: true)
        
        return
    }

}

