//
//  SpeechBubbleLabel.swift
//  MrFortuneCookie
//
//  Created by Thomas Harman on 4/19/16.
//  Copyright © 2016 Toms Apps. All rights reserved.
//

import UIKit

class SpeechBubbleLabel: UILabel {
    
    let speechBubble = UIImage(named: "speech-bubble")!.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 0, 40, 0), resizingMode: UIImageResizingMode.stretch)

    let textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 38, right: 15)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: textInsets.apply(rect))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = textInsets.apply(bounds)
        rect = super.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        return textInsets.inverse.apply(rect)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)        
//        // Drawing code
//        print("drawRect")
//        print("newWidth: \(rect.size.width)")
//        print("newHeight: \(rect.size.height)")
//    }
}

extension UIEdgeInsets {
    var inverse: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    func apply(_ rect: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(rect, self)
    }
}
