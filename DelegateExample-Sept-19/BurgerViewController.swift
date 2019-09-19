//
//  ViewController.swift
//  DelegateExample-Sept-19
//
//  Created by K Y on 9/19/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension UIView {
    func setupToFill(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}

enum Burger {
    case ham, cheese
}

protocol FoodProvider: class {
    func giveHamburger() -> Burger
}

class Waiter: FoodProvider {
    func giveHamburger() -> Burger {
        return .cheese
    }
}

class HamFanatic: FoodProvider {
    func giveHamburger() -> Burger {
        return .ham
    }
}

class BurgerViewController: UIViewController {
    
    var waiter: FoodProvider?
    var button: UIButton?
    
    init(_ foodProvider: FoodProvider) {
        waiter = foodProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button = UIButton(type: .custom)
        button?.setTitle("Fetch Burger", for: .normal)
        button?.setTitleColor(.blue, for: .normal)
        button?.setupToFill(superView: view)
        button?.addTarget(self, action: #selector(getBurger), for: .touchUpInside)
    }
    
    @objc func getBurger() {
        guard let burg = waiter?.giveHamburger() else { return }
        switch burg {
        case .ham:
            button?.setImage(UIImage(named: "ham"), for: .normal)
        case .cheese:
            button?.setImage(UIImage(named: "cheese"), for: .normal)
        }
    }
    


}

