//
//  FilterViewController.swift
//  Project2
//
//  Created by qwerty on 5/22/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var buttonBar: UIView!
    @IBOutlet weak var sortTypeLablel: UILabel!
    @IBOutlet weak var sortTypeSegmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
//        sortTypeSegmentControl.backgroundColor = .clear
        sortTypeSegmentControl.tintColor = .clear
        sortTypeSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 21),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)

        sortTypeSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 21),
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.orange
        buttonBar.topAnchor.constraint(equalTo: sortTypeSegmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: sortTypeSegmentControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: sortTypeSegmentControl.widthAnchor, multiplier: 1 / CGFloat(sortTypeSegmentControl.numberOfSegments)).isActive = true

        sortTypeSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.sortTypeSegmentControl.frame.width / CGFloat(self.sortTypeSegmentControl.numberOfSegments)) * CGFloat(self.sortTypeSegmentControl.selectedSegmentIndex) + (self.view.frame.width - self.sortTypeSegmentControl.frame.width) / 2
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
