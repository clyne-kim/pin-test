//
//  ViewController.swift
//  flexTest
//
//  Created by chanwoo on 2022/11/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .green
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            let vc = FlexTextViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }


}

