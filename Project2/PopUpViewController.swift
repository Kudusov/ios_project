//
//  PopUpViewController.swift
//  Project2
//
//  Created by qwerty on 5/25/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
    }

    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
