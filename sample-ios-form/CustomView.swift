//
//  CustomView.swift
//  sample-ios-form
//
//  Created by makoto.kaneko on 2018/07/06.
//  Copyright © 2018年 makoto.kaneko. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!

    //MARK: - Inspecable properties

    @IBInspectable var errorColor: UIColor = .red {
        didSet {
            messageLabel.textColor = errorColor
        }
    }
    
    // Hide / Show Error message
    @IBInspectable var hideError: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.175,
                           delay: 0.0,
                           options: [UIViewAnimationOptions.curveEaseInOut],
                           animations: {
                            self.messageLabel.isHidden = self.hideError
            },
                           completion: { _ in
                            //
            })

        }
    }
    
    // The error message to appear if validation fails
    @IBInspectable var errorMessage: String = "Error Message" {
        didSet {
            messageLabel.text = errorMessage
            //contentView.layoutIfNeeded()
        }
    }

    // The textField Placeholder
    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    // Default UI
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            textField.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            textField.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.darkGray {
        didSet {
            textField.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.white {
        didSet {
            textField.backgroundColor = bgColor
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.black {
        didSet {
            textField.textColor = textColor
        }
    }
    
    // UI Changes when value is valid
    @IBInspectable var validBorderColor: UIColor = UIColor.green
    @IBInspectable var validBgColor: UIColor = UIColor.green
    @IBInspectable var validTextColor: UIColor = UIColor.green
    @IBInspectable var validImage: UIImage? = nil
    
    // UI Changes when value is invalid
    @IBInspectable var invalidBorderColor: UIColor = UIColor.red
    @IBInspectable var invalidBgColor: UIColor = UIColor.red
    @IBInspectable var invalidTextColor: UIColor = UIColor.red
    @IBInspectable var invalidImage: UIImage? = UIImage(named: "form_validation_error")

    //MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    fileprivate func configureForTextField() {
        
    }

    fileprivate func loadNib() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("CustomView", owner: self, options: nil)
        guard let contentView = contentView else { return }
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["contentView" : contentView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: views))
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
