//
//  ViewController.swift
//  PawPal
//
//  Created by Puroof on 11/14/17.
//  Copyright © 2017 PawPal. All rights reserved.
//

import UIKit
import Alamofire
import LGButton
import SwiftyJSON
import Hero
import SnapKit
import MapKit


class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let nextButton: LGButton = {
        let button = LGButton()
        button.titleString = "NEXT"
        button.titleColor = UIColor.white
        button.sizeToFit()
        button.contentMode = .scaleToFill
        button.shadowOffset = CGSize(width: 3, height: 3)
        button.shadowRadius = 4
        button.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.cornerRadius = 22
        button.bgColor = UIColor(red:0.47, green:0.52, blue:0.95, alpha:1)
        button.shadowOffset = CGSize(width: 3, height: 3)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    let backButton: LGButton = {
        let button = LGButton()
        button.titleString = "Back"
        button.titleColor = UIColor(red:0.25, green:0.38, blue:0.45, alpha:1)
        button.sizeToFit()
        button.contentMode = .scaleToFill
        button.bgColor = UIColor(red:0.95, green:0.96, blue:0.97, alpha:1)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    }()
    
    let signInButton: LGButton = {
        let button = LGButton()
        button.titleString = "Sign in"
        button.titleColor = UIColor(red:0.25, green:0.38, blue:0.45, alpha:1)
        button.titleFontSize = 16
        button.sizeToFit()
        button.contentMode = .scaleToFill
        button.cornerRadius = 35
        button.spacingLeading = 29
        button.spacingTrailing = 29
        button.bgColor = UIColor(red:0.25, green:0.38, blue:0.45, alpha:0.1)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let titleBar: UIView = {
        let layer = UIView(frame: CGRect(x: -0.5, y: -26.5, width: 401, height: 111))
        layer.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.97, alpha:1)
        layer.layer.borderWidth = 1
        layer.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1).cgColor
        
        return layer
    }()
    
    
    var paybackLabel: UILabel = {
        let frame = CGRect(x: 10, y: 20, width: 300, height: 20)
        let label = UILabel(frame: frame)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: label.font.fontName, size:14)
        label.textColor = UIColor(red:0.25, green:0.38, blue:0.45, alpha:1)
        label.text = "Less than 0.5 miles away"
        return label
    }()
        
    
    var paybackSlider: ThickSlider = {
        let purpleColor = UIColor(red:0.49, green:0.51, blue:0.7, alpha:1)
        let frame = CGRect(x: 0, y: 0, width: 300, height: 25)
        let slider = ThickSlider(frame: frame)
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.isContinuous = true
        slider.thumbTintColor = purpleColor
        slider.tintColor = purpleColor
        slider.value = 500
        //slider.height = 20
        slider.addTarget(self, action: #selector(paybackSliderValueDidChange(sender:)), for: .valueChanged)
        return slider
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        
        let statueLocation = CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)
        let artwork = Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", disciple: "Sculpture", coordinate: statueLocation)
        mapView.addAnnotation(artwork)
        
        centerMapOnLocation(location: initialLocation)
    
        
        
        
//        self.view.addSubview(paybackLabel)
//        self.view.addSubview(paybackSlider)
//
//        let viewCenterHeight = self.view.frame.height / 2
//        let statusBarHeight = 111
//        let heightFromStatusBar = 238
//        let desiredOffset = Int(viewCenterHeight) - heightFromStatusBar - statusBarHeight
//        paybackSlider.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(desiredOffset)
//            make.width.equalToSuperview().offset(-42)
//            make.height.equalTo(15)
//        }
//
//
//        paybackLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(18)
//            make.bottom.equalTo(paybackSlider.snp.top).offset(-20)
//        }
//
//
//
//        self.view.addSubview(nextButton)
//        nextButton.layer.zPosition = 5
//        nextButton.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().offset(-30)
//            make.left.equalToSuperview().offset(68)
//            make.right.equalToSuperview().offset(-68)
//            make.height.equalTo(50)
//        }
//
//        self.view.addSubview(titleBar)
//        titleBar.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(20)
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(66.5)
//        }
//
//        titleBar.addSubview(backButton)
//        backButton.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview().offset(36.5)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(42)
//            make.height.lessThanOrEqualTo(20)
//            make.centerY.equalToSuperview()
//        }
//
//        titleBar.addSubview(signInButton)
//        signInButton.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.width.equalTo(110)
//            make.height.lessThanOrEqualTo(20)
//            make.centerY.equalToSuperview()
//        }
      
        
    }

    @objc func paybackSliderValueDidChange(sender: UISlider!)
    {
        print("payback value: \(sender.value)")
        paybackLabel.text = "\(sender.value)"
       
    }
    
    @objc func handleBack() {
        print("Handling Back")
    }
    
    @objc func handleButton() {
        print("Button pressed")
    }
    
    @objc func handleSignIn() {
        print("Handling Sign In")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// https://stackoverflow.com/questions/46317061/use-safe-area-layout-programmatically
extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

class ThickSlider: UISlider {
    
    var height: CGFloat = 13
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: height))
    }
}

