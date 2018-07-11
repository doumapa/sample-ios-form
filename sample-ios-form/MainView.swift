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
    @IBOutlet weak var goButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        bindSignal()
        configureForCustomView()
    }

    fileprivate func bindSignal() {
        goButton.reactive.pressed = CocoaAction(Action<Void, Void, NoError>() {
            print("ほげほげ")
            return SignalProducer.empty
        })
        let gesture = UITapGestureRecognizer()
        gesture.reactive.stateChanged
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] _ in
                self?.endEditing(true)
        }
        addGestureRecognizer(gesture)
        
        let enabledGoButton = { [weak self] (b: Bool) in
            self?.goButton.isEnabled = b
            self?.goButton.isUserInteractionEnabled = b
        }
        let fields = [
            firstNameView.isValid.signal,
            lastNameView.isValid.signal,
            coinNumberView.isValid.signal,
            customView.isValid.signal
        ]
        Signal.combineLatest(fields)
            .observeValues { (next: [Bool?]) in
                print("next: \(next)")
                enabledGoButton(next.filter({ (result: Bool?) -> Bool in
                    return result ?? false
                }).count == fields.count)
        }
    }

    fileprivate func configureForCustomView() {
        let continuousValidationRule = { (textField: UITextField) -> Bool? in
            guard let text = textField.text else { return nil }
            print("continuousValidationRule:\(text)")
            guard text.count <= 7 else {
                textField.text = String(text.prefix(7))
                return nil
            }
            return nil
        }
        firstNameView.continuousValidationRule = continuousValidationRule
        lastNameView.continuousValidationRule = continuousValidationRule
        coinNumberView.continuousValidationRule = continuousValidationRule
        customView.continuousValidationRule = continuousValidationRule
        let validationRule = { (textField: UITextField) -> Bool? in
            guard let text = textField.text else { return nil }
            print("validationRule:\(text)")
            return nil
        }
        firstNameView.validationRule = validationRule
        lastNameView.validationRule = validationRule
        coinNumberView.validationRule = validationRule
        customView.validationRule = validationRule
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
