//
//  BaseViewController.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var dataTransporter = ViewDataTransporter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self is AirportMapViewController {
            self.navigationController?.navigationBar.isHidden = true
        } else {
            self.navigationController?.navigationBar.isHidden = false
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let nextScreen = segue.destination as? BaseViewController
        nextScreen?.dataTransporter = self.dataTransporter
    }
}

// MARK: - ================================
// MARK: System default alert with message & title
// MARK: ================================

extension BaseViewController {
    /// A function to display an AlertView with appropriate title & message text
    func displayAlert(_ title: String, message: String, completion:((_ index: Int) -> Void)?, otherTitles: String? ...) {
        
        if message.trimmedString == "" {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if !otherTitles.isEmpty {
            // Create multiple buttons on Alertview as per given the list of titles
            for (i, title) in otherTitles.enumerated() {
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
                    if (completion != nil) {
                        completion!(i)
                    }
                }))
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                if (completion != nil) {
                    completion!(0)
                }
            }))
        }
        
        DispatchQueue.main.async {
            // Placed baseview just to handler orientation situation as per project's need
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // A method to display an alert with title
    func displayAlert(_ title: String = AppInfo.title , message: String) {
        displayAlert(title, message: message, completion: nil)
    }

}
