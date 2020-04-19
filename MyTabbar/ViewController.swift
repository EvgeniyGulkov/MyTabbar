//
//  ViewController.swift
//  MyTabbar
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum ArmStatus {
        case armed
        case disarmed
    }

    private let greenColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)
    private var panRecognizer: UIPanGestureRecognizer?
    private let lockImage = UIImage(named: "lock")
    private let unlockImage = UIImage(named: "unlock")
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var guardButton: UIButton!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var armInfoLabel: UILabel!
    @IBOutlet weak var guardButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var leftBar: UIStackView!
    @IBOutlet weak var rightBar: UIStackView!
    
    var isOpened = false
    var status: ArmStatus = .disarmed
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeSlider)))
        setupGuardView()
    }

    func configureGuardButton(state: ArmStatus) {
        guardButtonWidth.constant = 65
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
            return guardButtonWidth.constant = 65
        }
        self.view.bringSubviewToFront(guardButton)
        let translation = sender.translation(in: self.view)
        if guardButtonWidth.constant > widthConstraint.constant {
            changeState()
            closeSlider()
        } else if guardButtonWidth.constant > 64 {
            guardButtonWidth.constant += translation.x
        } else {
            guardButtonWidth.constant = 65
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    func openSlider() {
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
        guardButtonWidth.constant = 65
    }

    @objc
    func closeSlider() {
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
}

