//
//  IntercomViewController.swift
//  MyTabbar
//
//  Created by Gulkov on 24/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class IntercomeViewController: UIViewController {
    private var greenColor: UIColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentControl = UISegmentedControl(items: ["  Intercom           ", "  Cameras           "])
        segmentControl.selectedSegmentTintColor = greenColor
        segmentControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = segmentControl
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
