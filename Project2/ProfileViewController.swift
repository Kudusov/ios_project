//
//  ProfileViewController.swift
//  Project2
//
//  Created by qwerty on 5/21/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!

    private let tintColor = UIColor(hexString: "#ff5a66")
    private let subtitleColor = UIColor(hexString: "#464646")
    private let signUpButtonColor = UIColor(hexString: "#414665")
    private let signUpButtonBorderColor = UIColor(hexString: "#B0B3C6")
    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let subtitleFont = UIFont.boldSystemFont(ofSize: 18)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 24)

    override func viewWillAppear(_ animated: Bool) {
        setupConstraints()
        if (Int.random(in: 1...2)) == 1 {

            self.signupBtn.alpha = 1
            self.loginBtn.isHidden = true
            self.nameLabel.isHidden = false
            self.emailLabel.isHidden = false
            self.imageView.alpha = 1
        } else {
            self.imageView.alpha = 0
            self.nameLabel.text = "Вы не авторизованы"
            self.emailLabel.isHidden = true
            self.signupBtn.isHidden = false
            self.loginBtn.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.setTitle("Войти", for: .normal)
        loginBtn.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginBtn.configure(color: .white,
                              font: buttonFont,
                              cornerRadius: 55/2,
                              backgroundColor: tintColor)
        loginBtn.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        signupBtn.setTitle("Авторизоваться", for: .normal)
        signupBtn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        signupBtn.configure(color: signUpButtonColor,
                               font: buttonFont,
                               cornerRadius: 55/2,
                               borderColor: signUpButtonBorderColor,
                               backgroundColor: .white,
                               borderWidth: 1)
        signupBtn.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }

    @objc func didTapLoginButton() {
        let destinationVC = LoginScreenViewController(nibName: "LoginScreenViewController", bundle: nil)

        navigationController?.pushViewController(destinationVC, animated: true)
    }

    @objc func didTapSignUpButton() {
        let destinationVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)

        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func setupConstraints() {
        print("setupConstraints")
        self.imageView.image = UIImage(named: "logo")
        self.nameLabel.text = "sldkfjdsklfjds sdlkfjlsdkjf skdlfjsd"

    }
}
