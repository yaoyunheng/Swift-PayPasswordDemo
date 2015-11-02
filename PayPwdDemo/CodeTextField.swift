//
//  CodeTextField.swift
//  ZBBuyer
//
//  Created by yaoyunheng on 15/10/6.
//  Copyright © 2015年 ZhaoBu. All rights reserved.
//

import UIKit

class CodeTextField: UITextField {

    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == Selector("copy:") || action == Selector("selectAll:") || action == Selector("paste:") {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}
