//
//  HomeViewController.swift
//  MyTabbar
//
//  Created by Gulkov on 24/04/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    private var greenColor: UIColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ness corp"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "settings"), style: .plain, target: self, action: #selector(openSettings))
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = greenColor
    }

    @objc func openSettings() {
        let settingsSB = UIStoryboard(name: "Settings", bundle: nil)
        let settingsController = settingsSB.instantiateViewController(identifier: "SettingsViewController")
        self.navigationController?.pushViewController(settingsController, animated: true)
    }
}
