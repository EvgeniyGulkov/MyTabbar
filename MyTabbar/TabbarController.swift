//
//  ViewController.swift
//  MyTabbar
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TabbarController: UIViewController, selectIndexDelegate {

    enum ArmStatus {
        case armed
        case disarmed
    }

    private let greenColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)
    private let guardButtonWidthConstant: CGFloat = 65
    private var panRecognizer: UIPanGestureRecognizer?
    private let lockImage = UIImage(named: "lock")
    private let unlockImage = UIImage(named: "unlock")

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var firstIndex: TabbarItem!
    @IBOutlet weak var secondIndex: TabbarItem!
    @IBOutlet weak var thirdIndex: TabbarItem!
    @IBOutlet weak var lastIndex: TabbarItem!
    @IBOutlet weak var guardButton: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var armInfoLabel: UILabel!
    @IBOutlet weak var guardButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var leftBar: UIStackView!
    @IBOutlet weak var rightBar: UIStackView!
    @IBOutlet weak var maskView: UIView!
    
    var isOpened = false
    var status: ArmStatus = .disarmed
    var selectedIndex: Int = 0

    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeSlider))
        self.maskView.addGestureRecognizer(gestureRecognizer)
        setupGuardView()
        setupItems()
        setupViewControllers()
        select(item: firstIndex)
        maskView.isHidden = true
    }

    func setupViewControllers() {
        viewControllers = []

        let sb = UIStoryboard(name: "TabController", bundle: nil)
        let homeSB = UIStoryboard(name: "HomeScreen", bundle: nil)
        let dashboardSB = UIStoryboard(name: "Dashboard", bundle: nil)
        let intercomeSB = UIStoryboard(name: "Intercom", bundle: nil)

        let vc1 = homeSB.instantiateViewController(withIdentifier: "HomeViewController")
        let nc1 = NavigationController(rootViewController: vc1)
        let vc2 = dashboardSB.instantiateViewController(withIdentifier: "DashboardViewController")
        let nc2 = NavigationController(rootViewController: vc2)
        let vc3 = intercomeSB.instantiateViewController(withIdentifier: "IntercomeViewController")
        let nc3 = NavigationController(rootViewController: vc3)
        let vc4 = sb.instantiateViewController(withIdentifier: "ViewController")
        let nc4 = NavigationController(rootViewController: vc4)
        viewControllers.append(contentsOf: [nc1, nc2, nc3, nc4])
    }

    func setupItems() {
        firstIndex.delegate = self
        secondIndex.delegate = self
        thirdIndex.delegate = self
        lastIndex.delegate = self
        firstIndex.initItem(title: "Home", image: UIImage(named: "smarthome") ?? UIImage(), index: 0)
        secondIndex.initItem(title: "Dashboard", image: UIImage(named: "dashboard") ?? UIImage(), index: 1)
        thirdIndex.initItem(title: "Intercom", image: UIImage(named: "intercom") ?? UIImage(), index: 2)
        lastIndex.initItem(title: "More", image: UIImage(named: "more") ?? UIImage(), index: 3)
    }

    func configureGuardButton(state: ArmStatus) {
        guardButtonWidth.constant = guardButtonWidthConstant
        self.guardButton.layer.cornerRadius = slideView.layer.cornerRadius
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        if let recognizer = panRecognizer {
            guardButton.addGestureRecognizer(recognizer)
        }
        guardButton.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        switch state {
        case .armed:
            guardButton.setImage(lockImage, for: [])
            guardButton.backgroundColor = UIColor.red
        case .disarmed:
            guardButton.setImage(unlockImage, for: [])
            guardButton.backgroundColor = greenColor
        }
    }

    func setupGuardView() {
        slideView.layer.cornerRadius = self.slideView.frame.height/2
        slideView.layer.borderWidth = 2
        slideView.layer.borderColor = UIColor.gray.cgColor
        armInfoLabel.text = ""
        self.widthConstraint.constant = self.slideView.frame.height
        self.slideView.layoutIfNeeded()

        configureGuardButton(state: status)
        
        switch status {
        case .armed:
            armInfoLabel.textColor = UIColor.red
            armInfoLabel.text = "Slide to disarm"
        case .disarmed:
            armInfoLabel.textColor = greenColor
            armInfoLabel.text = "Slide to arm"
        }
    }

    @objc
    func draggedView(_ sender:UIPanGestureRecognizer) {
        guard isOpened else {
            return
        }
        guard sender.numberOfTouches != 0 else {
            return guardButtonWidth.constant = guardButtonWidthConstant
        }
        self.view.bringSubviewToFront(guardButton)
        let translation = sender.translation(in: self.view)
        if guardButtonWidth.constant > widthConstraint.constant {
            changeState()
            closeSlider()
        } else if guardButtonWidth.constant > guardButtonWidthConstant-1 {
            guardButtonWidth.constant += translation.x
        } else {
            guardButtonWidth.constant = guardButtonWidthConstant
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    func openSlider() {
        maskView.isHidden = false
        isOpened = true
        UIView.animate(withDuration: 0.2, animations: {
            self.widthConstraint.constant = self.view.frame.width*0.7
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.leftBar.isHidden = true
            self.rightBar.isHidden = true
        })
        switch status {
        case .armed:
            armInfoLabel.textColor = greenColor
            armInfoLabel.text = "Slide to disarm"
            guardButton.backgroundColor = greenColor
        case .disarmed:
            armInfoLabel.textColor = UIColor.red
            armInfoLabel.text = "Slide to arm"
            guardButton.backgroundColor = UIColor.red
        }
    }

    @objc func resizeButton() {
        guardButtonWidth.constant = guardButtonWidthConstant
    }

    @objc
    func closeSlider() {
        maskView.isHidden = true
        isOpened = false
        UIView.animate(withDuration: 0.2, animations: {
            self.leftBar.isHidden = false
            self.rightBar.isHidden = false
            self.widthConstraint.constant = self.slideView.frame.height
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.setupGuardView()
        })
    }

    func changeState() {
        if status == .armed {
            status = .disarmed
        } else {
            status = .armed
        }
    }

    @IBAction func guardButtonTouchUp(_ sender: Any) {
        if isOpened { closeSlider() } else { openSlider() }
    }

    func select(item: TabbarItem) {
        firstIndex.deselect()
        secondIndex.deselect()
        thirdIndex.deselect()
        lastIndex.deselect()
        item.select()
        showController(index: item.index)
    }

    func showController(index: Int) {
        let previousIndex = selectedIndex
        selectedIndex = index
        let previousVC = viewControllers[previousIndex]
        let vc = viewControllers[index]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
