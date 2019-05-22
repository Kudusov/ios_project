//
//  UIViewControlle.swift
//  Project2
//
//  Created by qwerty on 5/22/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
