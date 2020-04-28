//
//  SuccessViewController.swift
//  SignInWithAppleExample
//
//  Created by Nikita on 27/04/20.
//  Copyright © 2020 Nikita. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    open func setUserName(name:String){
        self.userName.text = "Welcome \(name)"
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
