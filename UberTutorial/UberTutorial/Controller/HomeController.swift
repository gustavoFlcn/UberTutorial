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

let reuseIndentifier = "LocationInputCell"

class HomeController: UIViewController{
    
    //MARK: -Propresties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()
    
    private final let locationInputViewHeight: CGFloat = 200
    
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
        inputActivationView.delegate = self
        locationInputView.delegate = self
        
        self.view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimension(height: 50, width: self.view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        inputActivationView.alpha = 0
        
        UIView.animate(withDuration: 2){
            self.inputActivationView.alpha = 1
        }
        
        configureTableView()
    }
    
    func configureMapView(){
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func configureLocationInputView(){
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
        }
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationInputCell.self, forCellReuseIdentifier: reuseIndentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        
        let tableViewHeight = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height,
                                 width: view.frame.width, height: tableViewHeight)
        view.addSubview(tableView)
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

//MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate{
    func presentLocationInputView() {
        inputActivationView.alpha = 0
        configureLocationInputView()
    }
}

//MARK: - LocationInputViewDelegate
extension HomeController: LocationInputViewDelegate{
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        }) { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3, animations: {
                self.inputActivationView.alpha = 1
            })
        }
    }
}

//MARK: - TableViewDelegate and TableViewDataSource
extension HomeController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath) as! LocationInputCell
        return cell
    }
    
    
}
