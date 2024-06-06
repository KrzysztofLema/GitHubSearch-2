//
//  LoginScreenView.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 05/06/2024.
//

import UIKit
import TinyConstraints

protocol LoginScreenViewDelegate: AnyObject {
    func loginScreenViewSignInButtonTapped(_ loginViewModel: LoginScreenView)
}

final class LoginScreenView: BasicView {
    
    weak var delegate: LoginScreenViewDelegate?
    
    private let viewModel: LoginScreenViewModel
    
    private let contentView = UIView()
    
    private let logoImageView = UIImageView()
    private let loginTitleLabel = UILabel()
    
    private let inputStackView = UIStackView()
    
    private let emailStackView = UIStackView()
    private let emailIcon = UIImageView()
    private let emailTextField = LoginTextField()
    
    private let passwordStackView = UIStackView()
    private let passwordIcon = UIImageView()
    private let passwordTextField = LoginTextField()
    
    private let signInButton = UIButton()

    init(viewModel: LoginScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(contentView)
        
        [logoImageView,
         loginTitleLabel,
         inputStackView,
         signInButton].forEach(contentView.addSubview(_:))
        
        [emailStackView,
         passwordStackView].forEach(inputStackView.addArrangedSubview(_:))
        
        [emailIcon,
         emailTextField].forEach(emailStackView.addArrangedSubview(_:))
        
        [passwordIcon,
         passwordTextField].forEach(passwordStackView.addArrangedSubview(_:))
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        backgroundColor = Color.background
        
        logoImageView.image = UIImage(systemName: "beach.umbrella.fill")
        logoImageView.tintColor = Color.darkTextColor
        
        loginTitleLabel.text = "Log in"
        loginTitleLabel.textColor = Color.darkTextColor
        loginTitleLabel.font = .systemFont(ofSize: 35, weight: .heavy)
                
        inputStackView.axis = .vertical
        inputStackView.spacing = 5
        
        emailStackView.axis = .horizontal
        
        emailIcon.image = UIImage(systemName: "at")
        emailIcon.tintColor = Color.darkTextColor
        emailIcon.contentMode = .center
        
        emailTextField.setupView(placeholderText: "Email")
        emailTextField.keyboardType = .emailAddress
        
        passwordStackView.axis = .horizontal
        
        passwordIcon.image = UIImage(systemName: "lock.circle")
        passwordIcon.tintColor = Color.darkTextColor
        passwordIcon.contentMode = .center
        
        passwordTextField.setupView(placeholderText: "Password")
        passwordTextField.isSecureTextEntry = true
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitle("", for: .disabled)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signInButton.backgroundColor = Color.darkButtonBackground
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        contentView.edgesToSuperview()
        
        logoImageView.width(80)
        logoImageView.height(80)
        
        emailIcon.width(30)
        emailIcon.height(30)
        
        passwordIcon.height(30)
        passwordIcon.width(30)
        
        logoImageView.centerXToSuperview()
        logoImageView.topToSuperview(offset: 50)
        
        loginTitleLabel.topToBottom(of: logoImageView, offset: 20)
        loginTitleLabel.centerX(to: logoImageView)
        
        inputStackView.topToBottom(of: loginTitleLabel, offset: 20)
        inputStackView.widthToSuperview(multiplier: 0.8)
        inputStackView.centerXToSuperview()
        
        signInButton.topToBottom(of: inputStackView, offset: 20)
        signInButton.widthToSuperview(multiplier: 0.8)
        signInButton.centerXToSuperview()
    }
    
    @objc private  func loginButtonTapped() {
        delegate?.loginScreenViewSignInButtonTapped(self)
    }
}
