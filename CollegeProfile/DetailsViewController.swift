//
//  DetailsViewController.swift
//  CollegeProfile
//
//  Created by Julianne Knott on 7/6/15.
//  Copyright © 2015 Julianne Knott. All rights reserved.
//

import UIKit


class DetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var webAddressTextField: UITextField!
    var imagePicker: UIImagePickerController!
    var webURL: NSURL!
    var college : College!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        nameTextField.text = college.name
        enrollmentTextField.text = String(college.enrollment)
        locationTextField.text = college.location
        imageView.image = college.image
        webAddressTextField.text = college.webAddress
        webURL = NSURL(string: webAddressTextField.text!)
    }
    
    @IBAction func onTappedSaveButton(sender: AnyObject) {
        college.name = nameTextField.text!
        if let num = Int(enrollmentTextField.text!) {
            college.enrollment = num
        }
        else{
            college.enrollment = 0
        }
        college.location = locationTextField.text!
        college.webAddress = webAddressTextField.text!
        college.image = self.imageView.image
        webURL = NSURL(string: webAddressTextField.text!)
    }
    
    @IBAction func TappedUpdateImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        self.presentViewController( imagePicker, animated: true , completion: nil)
    }
   
    @IBAction func TappedWebpage(sender: AnyObject) {
        webURL = NSURL(string: webAddressTextField.text!)
        UIApplication.sharedApplication().openURL(webURL!)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true) { () -> Void in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.imageView.image = image
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! MapViewController
        dvc.location = college.location
        dvc.name = college.name
    }
}
