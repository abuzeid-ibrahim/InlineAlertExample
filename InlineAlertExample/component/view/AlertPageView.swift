//
//  AlertPagerView.swift
//  InlineAlertExample
//
//  Created by Abuzeid Ibrahim on 12/3/18.
//  Copyright © 2018 abuzeid. All rights reserved.
//

import UIKit

protocol Sizable {
    func sizeChangedTo(newSize: CGSize)
}

class AlertPagerView: UIView, Sizable {
    var alerts: [InlineAlertView]!
    func sizeChangedTo(newSize _: CGSize) {}
    
    private var pageController: AlertPageViewController!
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, alerts: [InlineAlertView]) {
        self.init(frame: frame)
        self.alerts = alerts
        setPresentationLogic()
    }
    
    private func setPresentationLogic() {
        if alerts.count <= 1 {
            guard let alert = alerts.first else { return }
            addSubview(alert.view)
            alert.view.frame = bounds
        } else {
            //   let _ = alerts.map{$0.view.frame = CGRect(origin: CGPoint(x:($0.view.bounds.width - newSize.width)/2  , y: ($0.view.bounds.height - newSize.height)/2), size: newSize) }
            let newSize = self.bounds.size
            let newOrigin = self.center
            let _ = alerts.map{$0.view.frame = CGRect(origin: .zero, size: newSize) }
            let _ = alerts.map{$0.view.center = newOrigin }
            pageController = AlertPageViewController(alerts: alerts)
            pageController.view.frame = self.bounds
            inputViewController?.addChildViewController(pageController)
            addSubview(pageController.view)
        }
    }
}
