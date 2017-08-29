//
//  ViewController.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FortuneControllerProtocol, CAAnimationDelegate {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var fortuneCookieViewImg: UIImageView!
    @IBOutlet var fortuneLabel: SpeechBubbleLabel!
    
    var fortunesModel: PhoneFortunesModel?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.fortunesModel = PhoneFortunesModel(fortuneController: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default
            .addObserver(self, selector:#selector(ViewController.danceAndShowFortune), name:
                NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        self.fortuneLabel.isOpaque = false
        self.fortuneLabel.alpha = 0
        self.fortuneLabel.layer.zPosition = -1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        danceAndShowFortune()
    }
    
    @IBAction func gotTouch(_ sender: UIButton) {
        danceAndShowFortune()
    }
    
    func showGreedyMessage(message: String) {
        showFortune(fortune: message)
    }
    
    func showFortune(fortune: String) {
        self.fortuneLabel.text = fortune
        self.fortuneLabel.setNeedsLayout()
        self.fortuneLabel.layoutIfNeeded()
        self.fortuneLabel.alpha = 0
        
        // TODO - can we move this into SpeechBubbleLabel ?
        let speechBubble = UIImage(named: "speech-bubble")!.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 0, 40, 0), resizingMode: UIImageResizingMode.stretch)
        let imgSize = self.fortuneLabel.intrinsicContentSize
        UIGraphicsBeginImageContextWithOptions(imgSize, false, 0)
        speechBubble.draw(in: CGRect(x: 0, y: 0, width: imgSize.width, height: imgSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.fortuneLabel.backgroundColor = UIColor(patternImage: newImage!)
        
        
        self.fortuneLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: TimeInterval(3), animations: {
            self.fortuneLabel.transform =
                CGAffineTransform(translationX: 0, y: -150).concatenating(CGAffineTransform(scaleX: 1.0, y: 1.0))
            self.fortuneLabel.alpha = 1.0
            }, completion: {
                (val:Bool) in
                self.button.isUserInteractionEnabled = true
        })
    }
    
    func showRanOutOfFortunes(fortune: String) {
        showFortune(fortune: fortune)
    }
    
    func danceAndShowFortune() {
        self.fortuneLabel.alpha = 0
        dance(1, showFortune: true)
    }
    
    fileprivate func dance(_ numberOfShakes: Int, showFortune: Bool) {
        let animateDuration: CFTimeInterval = 0.25
        let beginTime = CACurrentMediaTime()
        var totalDuration: CFTimeInterval = 0
        
        // disable button until fortune shown
        button.isUserInteractionEnabled = false
        
        // TODO: Look into replacing this with a KeyFrameAnimation
        //        rightRotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        var lastReturnRotate = CABasicAnimation(keyPath: "transform.rotation")
        
        for _ in 0...numberOfShakes {
            let rightRotate = CABasicAnimation(keyPath: "transform.rotation")
            rightRotate.beginTime = beginTime + totalDuration
            rightRotate.fromValue = 0.0
            rightRotate.toValue = Double.pi * 0.05
            rightRotate.duration = animateDuration
            
            totalDuration += animateDuration
            
            let returnRotate = CABasicAnimation(keyPath: "transform.rotation")
            returnRotate.beginTime = beginTime + totalDuration
            returnRotate.fromValue = rightRotate.toValue
            returnRotate.toValue = CGFloat(0)
            returnRotate.duration = animateDuration
            
            totalDuration += animateDuration
            
            let leftRotate = CABasicAnimation(keyPath: "transform.rotation")
            leftRotate.beginTime = beginTime + totalDuration
            leftRotate.fromValue = returnRotate.toValue
            leftRotate.toValue = Double.pi * -0.05
            leftRotate.duration = animateDuration
            
            totalDuration += animateDuration
            
            lastReturnRotate = CABasicAnimation(keyPath: "transform.rotation")
            lastReturnRotate.beginTime = beginTime + totalDuration
            lastReturnRotate.fromValue = leftRotate.toValue
            lastReturnRotate.toValue = CGFloat(0)
            lastReturnRotate.duration = animateDuration
            lastReturnRotate.delegate = (self as CAAnimationDelegate)
            totalDuration += animateDuration
            
            self.fortuneCookieViewImg.layer.add(rightRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.add(returnRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.add(leftRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.add(lastReturnRotate, forKey: nil)
        }
        
        if (showFortune) {
            let triggerTimeSeconds = (Int64(NSEC_PER_SEC) * Int64(totalDuration - 1))
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTimeSeconds) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.fortunesModel!.makeFortune()
            })
        }
    }
}
