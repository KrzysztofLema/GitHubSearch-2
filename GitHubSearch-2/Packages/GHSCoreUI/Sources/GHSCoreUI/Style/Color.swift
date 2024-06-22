//
//  Color.swift
//  GitHubSearch-2
//
//  Created by Krzysztof Lema on 26/05/2024.
//

import UIKit

public enum Color {
    public static let background = UIColor(hexString: "#FFE4F3")
    public static let darkButtonBackground = UIColor(hexString: "#FF92C2")
    public static let lightButtonBackground = UIColor(hexString: "#FFC8FB")
    public static let lightTrim = UIColor(hexString: "#FFEEF2")
    public static let darkTextColor = UIColor(hexString: "#595758")
    public static let blackBorderColor = UIColor(hexString: "#000000")
    public static let lightGrayBorderColor = UIColor(hexString: "#D3D3D3")
    public static let redButtonBackground = UIColor(hexString: "#E32227")
    public static let whiteTextColor = UIColor(hexString: "#ffffff")
    public static let greenValidationTextColor = UIColor(hexString: "#00FF00")
    public static let redValidationTextColor = UIColor(hexString: "#FF0000")

    public enum Authentication {
        public static let googleButtonBorderColor = UIColor(hexString: "#888888")
        public static let googleButtonBackgroundColor = UIColor(hexString: "#ffffff")
        public static let googleButtonBaseBackgroundColor = UIColor(hexString: "#808080")

        public static let appleButtonBackgroundColor = UIColor(hexString: "#000000")
        public static let appleButtonBaseBackgroundColor = UIColor(hexString: "#ffffff")

        public static let facebookButtonBaseBackgroundColor = UIColor(hexString: "#ffffff")
        public static let facebookButtonBackgroundColor = UIColor(hexString: "#3b5998")

        public static let emailButtonBackgroundColor = UIColor(hexString: "#E32227")
        public static let emailButtonBaseBackgroundColor = UIColor(hexString: "#595758")
    }
}
