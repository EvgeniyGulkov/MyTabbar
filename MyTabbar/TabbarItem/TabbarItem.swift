//
//  GuardButtonLayers.swift
//  MyTabbar
//
//  Created by Admin on 05.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol selectIndexDelegate: class {
    func select(item: TabbarItem)
}

class TabbarItem: UIView {

    enum State {
        case `default`
        case selected
    }
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet var contentView: UIView!

    private var defaultColor: UIColor = UIColor.lightGray
    private var selectedColor: UIColor = UIColor(red: 137/255, green: 196/255, blue: 80/255, alpha: 1.0)
    private var state: State = .default

    weak var delegate: selectIndexDelegate?
    var index: Int = 0

    var selectColor: UIColor {
        get {
            return selectedColor
        }
        set {
            itemLabel.textColor = newValue
            itemImage.tintColor = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("TabbarItem", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        itemLabel.textColor = defaultColor
        itemImage.tintColor = defaultColor
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem)))
    }

    func initItem(title: String? = nil, image: UIImage? = nil, index: Int) {
        self.index = index
        itemLabel.text = title
        itemImage.image = image
    }

    func setTIntColor(color: UIColor, for state: [State]) {
        if state.isEmpty {
            defaultColor = color
            selectedColor = color
        }
        state.forEach { state in
            switch state {
            case .default:
                defaultColor = color
            case .selected:
                selectedColor = color
            }
        }
    }

    func setImage(image: UIImage?) {
        itemImage.image = image
    }

    func select() {
        state = .selected
        itemLabel.textColor = selectedColor
        itemImage.tintColor = selectedColor
    }

    func deselect() {
        itemLabel.textColor = defaultColor
        itemImage.tintColor = defaultColor
    }

    @objc func selectItem() {
        delegate?.select(item: self)
    }
}
