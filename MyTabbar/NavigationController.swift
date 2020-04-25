//
//  NavigationController.swift
//  MyTabbar
//
//  Created by Gulkov on 24/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    private var greenColor: UIColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = .black
        self.navigationBar.isOpaque = true
        self.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
