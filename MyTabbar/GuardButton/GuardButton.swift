//
//  GuardButtonLayers.swift
//  MyTabbar
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class GuardButton: UIView {
    var lHalfCircle: UIView!
    var rHalfCircle: UIView!
    var isArmed: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        self.backgroundColor = UIColor.clear
        createHalfCircle(left: true)
        createHalfCircle(left: false)
        self.addSubview(lHalfCircle)
        self.addSubview(rHalfCircle)
    }

    func createHalfCircle (left: Bool) {
        let view = UIView(frame: self.frame)
        let path = UIBezierPath()
        let shapeLayer = CAShapeLayer(layer: self.layer)

        if left {
            view.frame = CGRect(x: 0, y: 0, width: view.frame.height/2, height: view.frame.height)
            path.move(to: CGPoint(x: view.frame.height/2, y: view.frame.height))
            path.addArc(withCenter: CGPoint(x: view.frame.height/2,
                                            y: view.frame.height/2),
                        radius: view.frame.height/2, startAngle: 90*CGFloat.pi/180,
                        endAngle: 270*CGFloat.pi/180, clockwise: true)
            shapeLayer.fillColor = isArmed ? UIColor.red.cgColor : UIColor.green.cgColor
        } else {
            view.frame = CGRect(x: 0, y: 0, width: view.frame.height/2, height: view.frame.height)
            path.move(to: CGPoint(x: view.frame.height/2, y: view.frame.height))
            path.addArc(withCenter: CGPoint(x: view.frame.height/2,
                                            y: view.frame.height/2),
                        radius: view.frame.height/2, startAngle: 90*CGFloat.pi/180,
                        endAngle: 270*CGFloat.pi/180, clockwise: false)
            shapeLayer.fillColor = isArmed ? UIColor.red.cgColor : UIColor.green.cgColor
        }
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.path = path.cgPath
        shapeLayer.strokeEnd = 1
        view.layer.addSublayer(shapeLayer)
        if left {
            lHalfCircle = view
            self.addSubview(lHalfCircle)
        } else {
            rHalfCircle = view
            self.addSubview(rHalfCircle)
        }
    }
}
