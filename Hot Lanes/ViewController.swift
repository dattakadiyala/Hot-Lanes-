//
//  ViewController.swift
//  Hot Lanes
//
//  Created by Datta on 9/24/16.
//  Copyright © 2016 dvapps. All rights reserved.
//

import UIKit
import MapKit
import PMAlertController
import WebKit
import SafariServices
class ViewController: UIViewController, MKMapViewDelegate, WKNavigationDelegate, SFSafariViewControllerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mywebView: UIWebView!
    let regionRadius: CLLocationDistance = 12000
    private var urlString:String = "http://www.eenadu.net/18hyd-general9a.jpg"
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://www.eenadu.net/18hyd-general9a.jpg")!
        mywebView.loadRequest(URLRequest(url: url))
        // Do any additional setup after loading the view, typically from a nib.
        let initialLocation = CLLocation(latitude: 29.760427, longitude: -95.369803)
        mapView.delegate = self
        centerMapOnLocation(location: initialLocation)
        
        let ih10k = Lanes(title: "IH 10 KATY FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.784381, longitude: -95.461182), info: "1st lane")
        let ih45g = Lanes(title: "IH 45 GULF FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.742095, longitude: -95.357739), info: "2nd lane")
        let ih45n = Lanes(title: "IH 45 NORTH FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.781580, longitude: -95.368506), info: "3rd lane")
        let us59s = Lanes(title: "US 59 SOUTHWEST FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.732052, longitude: -95.389991), info: "4th lane")
        let us59e = Lanes(title: "US 59 EASTEX FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.773897, longitude: -95.340188), info: "5th Lane")
        let us290n = Lanes(title: "US 290 NORTHWEST FREEWAY", coordinate: CLLocationCoordinate2D(latitude: 29.803244, longitude: -95.451684), info: "6th line")
        mapView.addAnnotations([ih10k, ih45g, ih45n, us59s, us59e, us290n])
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 6.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: true)
      
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "myPinImage")
        }
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let lane = view.annotation as! Lanes
        let hovName = lane.title
        let hovInfo = lane.info
      
        let alertVC = PMAlertController(title: hovName!, description: hovInfo, image: nil , style: .alert)
        
        
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
        }))
        
        self.present(alertVC, animated: true, completion: nil)
        

    }
    @IBAction func openWithSafariVC(sender: AnyObject)
    {
        let svc = SFSafariViewController(url: URL(string: urlString)!)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}

