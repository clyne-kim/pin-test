//
//  FlexTextViewController.swift
//  flexTest
//
//  Created by chanwoo on 2022/11/12.
//

import Foundation
import UIKit
import FlexLayout
import Then
import PinLayout

final class FlexTextViewController: UIViewController {
    
    let label = UILabel().then {
        $0.text = "테스트 중입니다."
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let labelContainer = UIView().then {
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 10
    }
    
    let rectangle = UIView().then {
        $0.layer.cornerRadius = 14
        $0.layer.cornerCurve = .continuous
        $0.layer.borderColor = UIColor.systemYellow.cgColor
        $0.layer.borderWidth = 6
    }
    
    let dimTop = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    let dimLeft = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    let dimRight = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    let dimBottom = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dimTop.pin.top()
            .horizontally()
            .above(of: rectangle)
            .marginBottom(-6)
        
        dimBottom.pin.bottom()
            .horizontally()
            .below(of: rectangle)
            .marginTop(-6)
        
        dimLeft.pin.left()
            .below(of: dimTop)
            .above(of: dimBottom)
            .left(of: rectangle)
            .marginRight(-6)
        
        dimRight.pin.right()
            .below(of: dimTop)
            .above(of: dimBottom)
            .right(of: rectangle)
            .marginLeft(-6)
        
        labelContainer.pin
            .below(of: rectangle,
                   aligned: .center)
            .wrapContent(.horizontally, padding: 40)
            .wrapContent(.vertically, padding: 5)
            .marginTop(20)
        
        label.pin.pinEdges()
            .sizeToFit(.content)
        
        view.flex.layout()
        print(labelContainer.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dimTop)
        view.addSubview(dimBottom)
        view.addSubview(dimLeft)
        view.addSubview(dimRight)
        view.addSubview(rectangle)
        view.addSubview(labelContainer)
        labelContainer.addSubview(label)
        rectangle.frame = .init(x: 0,
                                y: view.center.y-14,
                                width: 320,
                                height: 28)
        view.setNeedsLayout()
//        rectangle.frame = .init(x: view.center.x-14, y: view.center.y-14, width: 28, height: 28)
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            UIView.animate(withDuration: 0.5,
                           delay: .zero,
                           options: [.curveEaseOut],
                           animations: {
                let v = self.view!
                self.rectangle.frame = .init(x: v.center.x-100, y: v.center.y-75, width: 200, height: 150)
                self.view.layoutIfNeeded()
            })
        })
        
        labelContainer.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            for _ in 0...999999 {
                autoreleasepool {
                    UIView.animate(withDuration: 0.5,
                                   delay: .zero,
                                   options: [.curveEaseOut],
                                   animations: {
                        self.labelContainer.alpha = 1
                        self.view.layoutIfNeeded()
                    })
                }
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            UIView.animate(withDuration: 0.5,
                           delay: .zero,
                           options: [.curveEaseOut],
                           animations: {
                let v = self.view!
                self.labelContainer.alpha = 0
                self.rectangle.frame = .init(x: v.center.x-100, y: v.center.y-150, width: 200, height: 300)
                self.view.layoutIfNeeded()
            })
        })
    }
}
