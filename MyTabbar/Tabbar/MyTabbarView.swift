//
//  MyTabbarView.swift
//  MyTabbar
//
//  Created by Admin on 19.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyTabbar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        
    }
}
