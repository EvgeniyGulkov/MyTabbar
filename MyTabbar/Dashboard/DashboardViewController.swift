//
//  DashboardViewController.swift
//  MyTabbar
//
//  Created by Gulkov on 24/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DashboardViewController: UITableViewController {
    private var greenColor: UIColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = greenColor
    }
}
