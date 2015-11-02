//
//  popPayPwdView.swift
//  PayPwdDemo
//
//  Created by yaoyunheng on 15/11/2.
//  Copyright © 2015年 yaoyunheng. All rights reserved.
//

let SCREEN_SIZE_WIDTH  = UIScreen.mainScreen().bounds.size.width
let SCREEN_SIZE_HEIGHT = UIScreen.mainScreen().bounds.size.height

import UIKit

@objc public protocol popPayDelegate {
    // MARK: - Delegate functions
    func compareCode(payCode: String)
}

public class popPayPwdView: UIView, UITextFieldDelegate {
    
    public init() {
        super.init(frame: CGRect(x: 40, y: (SCREEN_SIZE_HEIGHT - 190) / 2, width: SCREEN_SIZE_WIDTH - 80, height: 190))
        self.customInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public weak var delegate: popPayDelegate?

    var overlayView: UIControl!
    var payCodeTextField: CodeTextField!
    let lineTag = 1000
    let dotTag  = 3000
    var lineLabel: UILabel?
    var dotLabel: UILabel?
    let passWordLength = 6
    var pwdCode = ""
    
    func customInit() {
        self.backgroundColor = UIColor.whiteColor()
        overlayView = UIControl(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        overlayView.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        let titleLabel = UILabel(frame: CGRectMake(40, 0, self.frame.width - 80, 44))
        titleLabel.text = "Input your pay password"
        titleLabel.textAlignment = .Center
        titleLabel.font      = UIFont.systemFontOfSize(14)
        titleLabel.textColor = UIColor.blackColor()
        self.addSubview(titleLabel)
        
        let lineImageView0   = UIImageView(frame: CGRectMake(0, 44, self.frame.width, 0.5))
        lineImageView0.image = UIImage(named: "line")
        self.addSubview(lineImageView0)
        
        let cancelBtn = UIButton(frame: CGRectMake(0, 2, 40, 40))
        cancelBtn.setImage(UIImage(named: "cancel"), forState: UIControlState.Normal)
        cancelBtn.addTarget(self, action: "cancelBtnPressed", forControlEvents:UIControlEvents.TouchUpInside)
        self.addSubview(cancelBtn)
        
        let withDrawLabel = UILabel(frame: CGRectMake(self.frame.width / 2 - 25, 59, 50, 14))
        withDrawLabel.text = "title"
        withDrawLabel.textAlignment = .Center
        withDrawLabel.font      = UIFont.systemFontOfSize(13)
        withDrawLabel.textColor = UIColor.blackColor()
        self.addSubview(withDrawLabel)
        
        let moneyLabel = UILabel(frame: CGRectMake(0, 72, self.frame.width, 58))
        moneyLabel.text = "￥0.00"
        moneyLabel.textAlignment = .Center
        moneyLabel.font      = UIFont.systemFontOfSize(40)
        moneyLabel.textColor = UIColor.blackColor()
        self.addSubview(moneyLabel)
        
        payCodeTextField = CodeTextField(frame: CGRectMake(12, self.frame.height - 51, self.frame.width - 24, 36))
        payCodeTextField.backgroundColor = UIColor.whiteColor()
        payCodeTextField.layer.borderColor = UIColor(red: 0xe0/255.0, green: 0xe0/255.0, blue: 0xdf/255.0, alpha: 1.0).CGColor
        payCodeTextField.layer.borderWidth = 0.5
        payCodeTextField.secureTextEntry = true
        payCodeTextField.delegate = self
        payCodeTextField.tag = 102
        payCodeTextField.tintColor = UIColor.clearColor()
        payCodeTextField.textColor = UIColor.clearColor()
        payCodeTextField.font = UIFont.systemFontOfSize(30)
        payCodeTextField.keyboardType = UIKeyboardType.NumberPad
        payCodeTextField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        payCodeTextField.becomeFirstResponder()
        
        let frame = payCodeTextField.frame
        let perWidth = (frame.size.width - CGFloat(passWordLength) + 1) * 1.0 / CGFloat(passWordLength)
        for var i = 0; i < passWordLength; i++ {
            if i < passWordLength - 1 {
                lineLabel = payCodeTextField.viewWithTag(lineTag + i) as? UILabel
                if !(lineLabel != nil) {
                    lineLabel = UILabel()
                    lineLabel!.tag = lineTag + i
                    payCodeTextField.addSubview(lineLabel!)
                }
                lineLabel!.frame = CGRectMake(perWidth + (perWidth + 1) * CGFloat(i), 0, 0.5, frame.size.height)
                lineLabel!.backgroundColor = UIColor(red: 0xe0/255.0, green: 0xe0/255.0, blue: 0xdf/255.0, alpha: 1.0)
            }
            dotLabel = payCodeTextField.viewWithTag(dotTag + i) as? UILabel
            if !(dotLabel != nil) {
                dotLabel = UILabel()
                dotLabel!.tag = dotTag + i
                payCodeTextField.addSubview(dotLabel!)
            }
            dotLabel!.frame = CGRectMake((perWidth + 1) * CGFloat(i) + (perWidth - 10) * 0.5, (frame.size.height - 10) * 0.5, 10, 10)
            dotLabel!.layer.masksToBounds = true
            dotLabel!.layer.cornerRadius  = 5
            dotLabel!.backgroundColor = UIColor.blackColor()
            dotLabel!.hidden = true
        }
        self.addSubview(payCodeTextField)
    }

    public func cancelBtnPressed() {
        self.dismiss()
    }
    
    public func fadeIn() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.frame.origin.y = (SCREEN_SIZE_HEIGHT - self.frame.size.height) / 2 + 30
            }, completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.frame.origin.y -= 30
                    }, completion: { (finished: Bool) -> Void in
                        UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.frame.origin.y += 10
                            }, completion: { (finished: Bool) -> Void in
                                UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                    self.frame.origin.y -= 5
                                    }, completion: { (finished: Bool) -> Void in
                                        
                                })
                        })
                })
        })
    }
    
    public func fadeOut() {
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.frame.origin.y += 30
            }, completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.frame.origin.y = -self.frame.size.height
                    self.overlayView.alpha = 0.01
                    }, completion: { (finished: Bool) -> Void in
                        if finished {
                            self.payCodeTextField.resignFirstResponder()
                            self.overlayView.removeFromSuperview()
                            self.removeFromSuperview()
                        }
                })
        })
    }
    
    public func pop() {
        let keyWindow = UIApplication.sharedApplication().keyWindow!
        keyWindow.addSubview(overlayView)
        keyWindow.addSubview(self)
        self.center = CGPointMake(keyWindow.bounds.size.width / 2.0,
            keyWindow.bounds.size.height / 2.0)
        fadeIn()
    }
    
    public func dismiss() {
        fadeOut()
    }

    func textFieldDidChange() {
        let length = payCodeTextField.text!.characters.count
        if length == passWordLength {
            dismiss()
            delegate?.compareCode(payCodeTextField.text!)
        }
        for var i = 0; i < passWordLength; i++ {
            dotLabel = payCodeTextField.viewWithTag(dotTag + i) as? UILabel
            if (dotLabel != nil) {
                dotLabel!.hidden = length <= i
            }
        }
        payCodeTextField.sendActionsForControlEvents(.ValueChanged)
    }

}
