//
//  ViewController.swift
//  PayPwdDemo
//
//  Created by yaoyunheng on 15/11/2.
//  Copyright © 2015年 yaoyunheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, popPayDelegate {

    var popPayView: popPayPwdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func inputPwdBtnPressed(sender: UIButton) {
        popPayView = popPayPwdView()
        popPayView!.delegate = self
        popPayView!.pop()
    }
    
    var yourPayCode = "111111"
    
    func compareCode(payCode: String) {
        if payCode == yourPayCode {
            print("inputPwd successed")
            let con = UIViewController()
            con.title = "Successed"
            con.view.backgroundColor = UIColor.redColor()
            self.navigationController?.pushViewController(con, animated: true)
        } else {
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: nil, message: "PassWord Error", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                    
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true) {
                    
                }
            } else {
                let errorAlertView = UIAlertView(title: "PassWord Error", message: "Please try again", delegate: self, cancelButtonTitle: "Ok")
                errorAlertView.show()
            }
        }
    }
}

