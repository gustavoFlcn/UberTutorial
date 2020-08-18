//
//  LocationInputActivationView.swift
//  UberTutorial
//
//  Created by Gustavo Feliciano Figueiredo on 17/08/20.
//  Copyright © 2020 Gustavo Feliciano Figueiredo. All rights reserved.
//

import Foundation
import UIKit

protocol LocationInputActivationViewDelegate: class {
     func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    //MARK: - Properties
    weak var delegate: LocationInputActivationViewDelegate?
    private let indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let placeHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
        
        self.addSubview(indicatorView)
        self.indicatorView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 16)
        self.indicatorView.setDimension(height: 6, width: 6)
        
        self.addSubview(placeHolderLabel)
        placeHolderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentLocationInputView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func presentLocationInputView(){
        delegate?.presentLocationInputView()
    }
}
