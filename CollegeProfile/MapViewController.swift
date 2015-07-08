//
//  MapViewController.swift
//  CollegeProfile
//
//  Created by Julianne Knott on 7/8/15.
//  Copyright © 2015 Julianne Knott. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var location = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = "\(name), \(location)"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!, completionHandler:
            {placemarks, error in
                if error != nil {
                    print(error)
                }
                else {
                    let placemark = placemarks!.first as CLPlacemark!
                    let center = placemark.location.coordinate
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    self.displayMap(center, span: span, pinTitle: self.name)

                }
        })

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!, completionHandler:
            {placemarks, error in
                if error != nil {
                    print(error)
                }
                else {
                    let actionSheet = UIAlertController(title: "Map", message: "Select Location", preferredStyle: .ActionSheet)
                    var placemark = placemarks!.first
                    var counter = -1
                    while ((counter < 10) && (counter < placemarks!.count-1)) {
                        counter++
                        print(counter)
                        let action = UIAlertAction(title: (placemarks![counter].name! + ", " + placemarks![counter].locality! + ", " + placemarks![counter].administrativeArea), style: .Default, handler: { (action) -> Void in
                                placemark = placemarks![counter] as CLPlacemark!
                                let center = placemark!.location.coordinate
                                let span = MKCoordinateSpanMake(0.1, 0.1)
                                self.name = placemark!.name + ", " + placemark!.locality + ", " + placemark!.administrativeArea
                                self.displayMap(center, span: span, pinTitle: self.name)
                        })
                        actionSheet.addAction(action)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) ->Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    actionSheet.addAction(cancelAction)
                    self.presentViewController(actionSheet, animated: true, completion: nil)
                }
        })//note this ), this is all part of method header, closure is contained in method header!!!
        textField.resignFirstResponder() // gets rid of keyboard
        return true
    }
    
    func displayMap(center: CLLocationCoordinate2D,
        span: MKCoordinateSpan,
        pinTitle: String){
            let region = MKCoordinateRegionMake(center, span)
            let pin = MKPointAnnotation()
            pin.coordinate = center
            pin.title = pinTitle
            mapView.addAnnotation(pin)
            mapView.setRegion(region, animated: true)
    }


}
