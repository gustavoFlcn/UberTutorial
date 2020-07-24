//
//  HomeController.swift
//  UberTutorial
//
//  Created by Gustavo Feliciano Figueiredo on 24/07/20.
//  Copyright © 2020 Gustavo Feliciano Figueiredo. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController{
    
    //MARK: -Propresties
    
    //MARK: -Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserIsLoggedIn()
        view.backgroundColor = .red
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
            print("DEBUG: User id is \(Auth.auth().currentUser?.uid)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
        } catch  {
            print("DEBUG: Error signing out")
        }
    }
}
