//
//  MainView.swift
//  sample-ios-form
//
//  Created by makoto.kaneko on 2018/06/01.
//  Copyright © 2018年 makoto.kaneko. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import ReactiveCocoa

class MainView: UIView {

    @IBOutlet weak var firstNameView: CustomView!
    @IBOutlet weak var lastNameView: CustomView!
    @IBOutlet weak var coinNumberView: CustomView!
    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var onOffButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        bindSignal()
    }

    fileprivate func bindSignal() {
        let action = Action<Bool, Void, NoError>() { [weak self] (isSelected: Bool) in
            if isSelected {
                self?.firstNameView.hideError = false
                self?.lastNameView.hideError = false
                self?.coinNumberView.hideError = false
                self?.customView.hideError = false
            } else {
                self?.firstNameView.hideError = true
                self?.lastNameView.hideError = true
                self?.coinNumberView.hideError = true
                self?.customView.hideError = true
            }
            return SignalProducer.empty
        }
        onOffButton.reactive.pressed = CocoaAction(action, { (sender: UIButton) in
            sender.isSelected = !(sender.isSelected)
            return sender.isSelected
        })
        let gesture = UITapGestureRecognizer()
        gesture.reactive.stateChanged
        .take(duringLifetimeOf: self)
            .observeValues { [weak self] _ in
                self?.endEditing(true)
        }
        addGestureRecognizer(gesture)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
