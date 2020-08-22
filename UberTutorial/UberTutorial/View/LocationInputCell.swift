//
//  LocationInputCell.swift
//  UberTutorial
//
//  Created by Gustavo Feliciano Figueiredo on 21/08/20.
//  Copyright © 2020 Gustavo Feliciano Figueiredo. All rights reserved.
//

import UIKit

class LocationInputCell: UITableViewCell {

    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "My House"
        return label
    }()
    
    var addressLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Quadra 91 lote 14, Sad-GO"
        return label
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
