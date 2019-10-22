//
//  Extensions.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: - ================================
// MARK: String
// MARK: ================================

extension String {
    var trimmedString: String { return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
    
    var length: Int { return self.count }
    
    /**
     To map the string with localised synonym.
     */
    func localised() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func stringFromDate(inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
}

// MARK: - ================================
// MARK: UIView
// MARK: ================================

extension UIView {
    // To set border color directly through storyboard or .XIB
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // To set border width directly through storyboard or .XIB
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // To set corner radius directly through storyboard or .XIB
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

//MARK: - MKPointAnnotation

extension MKPointAnnotation {
    struct Annotation {
        static var tag: Int = 0
    }
    var tag: Int {
        get {
            return Annotation.tag
        }
        set(newValue) {
            Annotation.tag = newValue
        }
    }
}
