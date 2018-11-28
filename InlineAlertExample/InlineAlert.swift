//
//  InlineAlert.swift
//  InlineAlertExample
//
//  Created by Abuzeid Ibrahim on 11/28/18.
//  Copyright © 2018 abuzeid. All rights reserved.
//


import UIKit
import Foundation
import UIKit


final class VFInlineAlert:UIView,InlineAlert{
    init(frame: CGRect, icon: UIImage  = #imageLiteral(resourceName: "infoCircle")) {
        super.init(frame: frame)
        initView(icon: icon)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView(icon: #imageLiteral(resourceName: "infoCircle"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let stackView = UIStackView()
    
    func append(view: UIView) -> Self {
        stackView.addSubview(view)
        return self
    }
    func appendText(text: NSAttributedString) -> Self {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.widthAnchor.constraint(equalToConstant: stackView.bounds.width - Style.bodyPadding ).isActive = true
        stackView.addArrangedSubview(label)
        return self
    }
    
    func trimBottomSpace() -> Self {
        let label = UILabel()
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        stackView.addArrangedSubview(label)
        return self
    }
    
    func addVerticalSeperator() -> Self {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        
        sep.backgroundColor = Style.seperatorColor
        sep.widthAnchor.constraint(equalToConstant: stackView.bounds.width - Style.bodyPadding ).isActive = true
        sep.heightAnchor.constraint(equalToConstant: 1 ).isActive = true
        
        stackView.addArrangedSubview(sep)
        return self
    }
    func addPadding() -> Self {
        let padding = UIView()
        padding.translatesAutoresizingMaskIntoConstraints = false
        padding.backgroundColor = UIColor.clear
        padding.heightAnchor.constraint(equalToConstant: Style.bodyPadding ).isActive = true
        stackView.addArrangedSubview(padding)
        return self
    }
    func addAction(title: String, action: @escaping ButtonAction) -> Self {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.widthAnchor.constraint(equalToConstant: stackView.bounds.width - Style.bodyPadding ).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40 ).isActive = true
        button.setTitle(title, for: .normal)
        button.backgroundColor = Style.buttonBG
        button.actionHandle(control: .touchUpInside,
                            forAction:{() -> Void in
                                action()
        })
        
        stackView.addArrangedSubview(button)
        return self
    }
    
    
    
}
extension VFInlineAlert{
    struct Style{
        static let seperatorColor = UIColor.gray
        static let buttonBG = UIColor.gray
        static let primaryBGColor = UIColor.purple
        static let leadingViewWidth:CGFloat = 40
        static let bodyPadding:CGFloat = 10
    }
}
private extension VFInlineAlert{
    func setLeadingView(icon:UIImage){
        let leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Style.leadingViewWidth, height: self.bounds.height)))
        leftView.backgroundColor = Style.primaryBGColor
        let iconDim =  Style.leadingViewWidth -  Style.bodyPadding
        let iconView = UIImageView(frame: CGRect(x: Style.bodyPadding , y: Style.bodyPadding, width: iconDim, height: iconDim))
        iconView.image = icon
        leftView.addSubview(iconView)
        self.addSubview(leftView)
    }
    
    func setBodyView(){
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = Style.bodyPadding
        let stFrame = CGRect(origin: CGPoint(x: Style.leadingViewWidth + Style.bodyPadding, y: 0),
                             size:  CGSize(
                                width: self.bounds.width - (Style.leadingViewWidth + (2*Style.bodyPadding)),
                                height: self.bounds.height - (2*Style.bodyPadding)))
        let stackContainer = UIView(frame: stFrame)
        stackContainer.addSubview(stackView)
        stackView.frame = stackContainer.bounds
        self.addSubview(stackContainer)
        
        
    }
    func initView(icon:UIImage){
        self.setLeadingView(icon: icon)
        self.setBodyView()
        self.setCorners(borderColor:Style.primaryBGColor)
    }
    
}
