//
//  RatingViewController.swift
//  Project2
//
//  Created by qwerty on 5/25/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON

extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
}
class RatingViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var superViewHeight: NSLayoutConstraint!
    @IBOutlet weak var superViewWidth: NSLayoutConstraint!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var ratingStarView: CosmosView!
    @IBOutlet weak var yourMarkLbl: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var estimateBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var cafeId: Int?
    var userReview: Review?
    var ratingUpdateDelefate: RatingUpdateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        designView()

    }

    private func designView() {
        if superViewWidth.constant > 0.7 * UIScreen.main.bounds.width {
            superViewWidth.constant = 0.7 * UIScreen.main.bounds.width
        }

        estimateBtn.isEnabled = false
        estimateBtn.setTitleColor(.gray, for: .disabled)
//        estimateBtn.setTitleColor(, for: .disabled)

        firstView.layer.masksToBounds = true
        firstView.layer.cornerRadius = 10

        secondView.layer.masksToBounds = true
        secondView.layer.cornerRadius = 10

        let borderWidth: CGFloat = 1.0
        let borderColor : UIColor =  UIColor.lightGray
        estimateBtn.addBottomBorderWithColor(color: borderColor, width: borderWidth)
        ratingStarView.settings.starSize = 30
        ratingStarView.settings.starMargin = 5
        ratingStarView.settings.totalStars = 5
        ratingStarView.settings.minTouchRating = 1
        ratingStarView.rating = 1
        ratingStarView.didTouchCosmos = { rating in
            self.yourMarkLbl.text = "Ваша оценка: " + String.localizedStringWithFormat("%.1f", rating)
            self.estimateBtn.isEnabled = true
        }
        reviewTextView.delegate = self
        if userReview == nil {
            reviewTextView.text = "Ваш отзыв"
            reviewTextView.textColor = UIColor.lightGray

        } else {
            self.yourMarkLbl.text = "Ваша оценка: " + String.localizedStringWithFormat("%.1f", userReview!.rating)
            ratingStarView.rating = Double(userReview!.rating)
            
            if userReview?.review != ""{
                reviewTextView.text = userReview?.review
            } else {
                reviewTextView.text = "Ваш отзыв"
                reviewTextView.textColor = UIColor.lightGray
            }
        }


    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Ваш отзыв"
            textView.textColor = UIColor.lightGray
        }
    }

    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func estimateBtnTapped(_ sender: Any) {
        let rating = ratingStarView.rating
        var review = reviewTextView.text ?? ""
        if review == "Ваш отзыв" {
            review = ""
        }

        estimate(cafeId: self.cafeId!, rating: Float(rating), review: review) { error in
//            print(error)

            if error == .success {
                print("success")
                if self.ratingUpdateDelefate != nil {
                    self.ratingUpdateDelefate?.ratingUpdated()
                }
                self.dismiss(animated: true, completion: nil)
            } else if error == .incorrectCredentials {
                let authManager = MyAuthManager()
                authManager.refreshToken() { authError in
                    if authError != .success {
                        print("Auth Error")
                    } else {
                        self.estimate(cafeId: self.cafeId!, rating: Float(rating), review: review) { estError in
                            if error != .success {
                                print("some Error")
                            } else {
                                if self.ratingUpdateDelefate != nil {
                                    self.ratingUpdateDelefate?.ratingUpdated()
                                }
                                self.dismiss(animated: true, completion: nil)
                            }

                        }
                    }
                }
            }

        }
    }
    
    func estimate(cafeId: Int, rating: Float, review: String, completionBlock: @escaping (_ success: AuthError) -> Void) {
        guard let url = URL(string: baseUrl + "/api/marks/") else {
            completionBlock(.someError)
            return
        }

        let credentials = AuthBearer.getCredentials()
        if (credentials.accessToken == "" || credentials.refreshToken == "") {
            completionBlock(.someError)
            return
        }

        Alamofire.request(url, method: .put, parameters: ["cafe_id": cafeId, "rating": rating, "review": review], encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + credentials.accessToken]).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(.someError)
                return;
            }

            if resp.statusCode == 200 {
                if let json = try? JSON(data: dataResponse.data!) {
                    print(json["message"].stringValue)
                    completionBlock(.success)
                }
            } else if resp.statusCode == 401 {
                completionBlock(.incorrectCredentials)
            } else {
                completionBlock(.someError)
            }
        }

    }
}
