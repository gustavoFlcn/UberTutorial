//
//  LocationInputView.swift
//  UberTutorial
//
//  Created by Gustavo Feliciano Figueiredo on 18/08/20.
//  Copyright © 2020 Gustavo Feliciano Figueiredo. All rights reserved.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dismissLocationInputView()
}

class LocationInputView: UIView {

    //MARK: - Properties
    weak var delegate : LocationInputViewDelegate?
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gustavo Feliciano"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var startLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Current Location"
        textField.backgroundColor = .groupTableViewBackground
        textField.isEnabled = false
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var destinationLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a Destination"
        textField.backgroundColor = .lightGray
        textField.returnKeyType = .search
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimension(height: 30, width: 8)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let startLoctionIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationLoctionIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
        
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addShadow()
        
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor,paddingTop: 44,
                          paddingLeft: 12,width: 24, height: 25)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(startLocationTextField)
        startLocationTextField.anchor(top: backButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 40, paddingRight: 40, height: 30)
        
        addSubview(startLoctionIndicatorView)
        startLoctionIndicatorView.centerY(inView: startLocationTextField, leftAnchor: leftAnchor, paddingLeft: 20)
        startLoctionIndicatorView.anchor(width: 6, height: 6)
        startLoctionIndicatorView.layer.cornerRadius = 6/2
        
        addSubview(destinationLoctionIndicatorView)
        destinationLoctionIndicatorView.centerY(inView: destinationLocationTextField, leftAnchor: leftAnchor, paddingLeft: 20)
        destinationLoctionIndicatorView.anchor(width: 6, height: 6)
        
        addSubview(linkingView)
        linkingView.centerX(inView: startLoctionIndicatorView)
        linkingView.anchor(top: startLoctionIndicatorView.bottomAnchor,
                           bottom: destinationLoctionIndicatorView.topAnchor,
                           paddingTop: 4, paddingBottom: 4, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleBackTapped(){
        delegate?.dismissLocationInputView()
    }
}
