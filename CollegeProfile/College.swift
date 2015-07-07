//
//  College.swift
//  CollegeProfile
//
//  Created by Julianne Knott on 7/6/15.
//  Copyright © 2015 Julianne Knott. All rights reserved.
//
import UIKit

class College{

    var name = ""
    var location = ""
    var enrollment = 0
    var image = UIImage(named: "Default")
    var webAddress = "http://www.google.com"
    
    convenience init(collegeName: String, collegeLocation: String, collegeEnrollment: Int, collegeImage: UIImage){
        self.init()
        name = collegeName
        location = collegeLocation
        enrollment = collegeEnrollment
        image = collegeImage
    }
    
    convenience init(collegeName: String, collegeLocation: String){
        self.init()
        name = collegeName
        location = collegeLocation
        enrollment = 0
        image = UIImage(named:"Default")
    }
}
