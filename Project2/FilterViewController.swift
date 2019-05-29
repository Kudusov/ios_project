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
    @IBOutlet weak var fiterBtn: UIButton!
    var filterDelegate: FilterDelegateProtocol?
    var filter = Filter()
    private let backgroundColor: UIColor = .white
    private let tintColor = UIColor(hexString: "#1478f6")

    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 20)

    var logButton : UIBarButtonItem = UIBarButtonItem(title: "Сброс", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapClearButton))

    override func viewDidLoad() {
        super.viewDidLoad()
        logButton = UIBarButtonItem(title: "Сброс", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapClearButton))
        sortTypeSegmentControl.tintColor = .clear
        sortTypeSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "#54cff9")
            ], for: .normal)

        sortTypeSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "#54cff9")
            ], for: .selected)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(hexString: "54cff9")
        buttonBar.topAnchor.constraint(equalTo: sortTypeSegmentControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true

        buttonBar.widthAnchor.constraint(equalTo: sortTypeSegmentControl.widthAnchor, multiplier: 1 / CGFloat(sortTypeSegmentControl.numberOfSegments)).isActive = true


        fiterBtn.setTitle("Применить", for: .normal)
        fiterBtn.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        fiterBtn.configure(color: backgroundColor,
                              font: buttonFont,
                              cornerRadius: 36/2,
                              backgroundColor: tintColor)

        navigationItem.rightBarButtonItem = logButton
        sortTypeSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        if filter.sortType == .rating {
            self.sortTypeSegmentControl.selectedSegmentIndex = 1
            buttonBar.rightAnchor.constraint(equalTo: sortTypeSegmentControl.rightAnchor).isActive = true
        } else {
            self.sortTypeSegmentControl.selectedSegmentIndex = 0
            buttonBar.leftAnchor.constraint(equalTo: sortTypeSegmentControl.leftAnchor).isActive = true
        }
        segmentedControlValueChanged(self.sortTypeSegmentControl)

    }



    @objc func didTapFilterButton() {
        if filterDelegate != nil {
            let filter = Filter()
            switch self.sortTypeSegmentControl.selectedSegmentIndex {
            case 0:
                filter.sortType = .distance
            case 1:
                filter.sortType = .rating
            default:
                filter.sortType = .defaulted
            }

            filterDelegate?.filterUpdated(filter: filter)
        }

        navigationController?.popViewController(animated: true)

    }

    @objc func didTapClearButton() {
        print("Clear")
        self.filter = Filter()
        if filterDelegate != nil {
            filterDelegate?.filterReseted()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {

        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.sortTypeSegmentControl.frame.width / CGFloat(self.sortTypeSegmentControl.numberOfSegments)) * CGFloat(self.sortTypeSegmentControl.selectedSegmentIndex) + (self.view.frame.width - self.sortTypeSegmentControl.frame.width) / 2
        }
    }


}
