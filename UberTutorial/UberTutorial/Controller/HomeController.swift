//
//  HomeController.swift
//  UberTutorial
//
//  Created by Gustavo Feliciano Figueiredo on 24/07/20.
//  Copyright © 2020 Gustavo Feliciano Figueiredo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth

import MapKit

class HomeController: UIViewController{
    
    //MARK: -Propresties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    
    
    //MARK: -Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserIsLoggedIn()
//        signOut()
        enableLocationServices()
    }
    
    //MARK: - API
    func checkUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            configureUI()
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch  {
            print("DEBUG: Error signing out")
        }
    }
    
    //MARK: -Helper Functions
    func configureUI(){
        configureMapView()
        
        self.view.addSubview(inputActivationView)
        inputActivationView.delegate = self
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimension(height: 50, width: self.view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        inputActivationView.alpha = 0
        
        UIView.animate(withDuration: 2){
            self.inputActivationView.alpha = 1
        }
    }
    
    func configureMapView(){
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}

//MARK: -Location Services
extension HomeController: CLLocationManagerDelegate{
    func enableLocationServices(){
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("DEBUG: Not determined...")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("DEBUG: Auth always...")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use...")
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse{
            locationManager.requestAlwaysAuthorization()
        }
    }
}

extension HomeController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        print(123)
    }
    
    
}