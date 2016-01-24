//
//  ViewController.swift
//  FortuneCookie
//
//  Created by Thomas Harman on 9/13/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FortuneControllerProtocol {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var fortuneCookieViewImg: UIImageView!
    @IBOutlet var fortuneLabel: SpeechBubbleLabel!
    
    var fortunesModel: PhoneFortunesModel?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.fortunesModel = PhoneFortunesModel(fortuneController: self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter
            .defaultCenter()
            .addObserver(self, selector:#selector(ViewController.danceAndShowFortune), name:
                UIApplicationWillEnterForegroundNotification, object: nil)

        self.fortuneLabel.opaque = false
        self.fortuneLabel.alpha = 0
        self.fortuneLabel.layer.zPosition = -1
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        danceAndShowFortune()
    }
    
    @IBAction func gotTouch(sender: UIButton) {
        danceAndShowFortune()
    }
    
    func showGreedyMessage(greedyMessage: String) {
        showFortune(greedyMessage)
    }
    
    func showFortune(fortune: String) {
        self.fortuneLabel.text = fortune
        self.fortuneLabel.setNeedsLayout()
        self.fortuneLabel.layoutIfNeeded()
        self.fortuneLabel.alpha = 0
        
        // TODO - can we move this into SpeechBubbleLabel ?
        let speechBubble = UIImage(named: "speech-bubble")!.resizableImageWithCapInsets(UIEdgeInsetsMake(15, 0, 40, 0), resizingMode: UIImageResizingMode.Stretch)
        let imgSize = self.fortuneLabel.intrinsicContentSize()
        UIGraphicsBeginImageContextWithOptions(imgSize, false, 0)
        speechBubble.drawInRect(CGRectMake(0, 0, imgSize.width, imgSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.fortuneLabel.backgroundColor = UIColor(patternImage: newImage)
        
        
        self.fortuneLabel.transform = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(NSTimeInterval(3), animations: {
            self.fortuneLabel.transform =
                CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -150), CGAffineTransformMakeScale(1.0, 1.0))
            self.fortuneLabel.alpha = 1.0
            }, completion: {
                (val:Bool) in
                self.button.userInteractionEnabled = true
        })
    }
    
    func showRanOutOfFortunes(fortune: String) {
        showFortune(fortune)
    }
    
    func danceAndShowFortune() {
        self.fortuneLabel.alpha = 0
        dance(1, showFortune: true)
    }
    
    private func dance(numberOfShakes: Int, showFortune: Bool) {
        let animateDuration: CFTimeInterval = 0.25
        let beginTime = CACurrentMediaTime()
        var totalDuration: CFTimeInterval = 0
        
        // disable button until fortune shown
        button.userInteractionEnabled = false
        
        // TODO: Look into replacing this with a KeyFrameAnimation
        //        rightRotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        var lastReturnRotate = CABasicAnimation(keyPath: "transform.rotation")
        
        for _ in 0...numberOfShakes {
            let rightRotate = CABasicAnimation(keyPath: "transform.rotation")
            rightRotate.beginTime = beginTime + totalDuration
            rightRotate.fromValue = 0.0
            rightRotate.toValue = CGFloat(M_PI * 0.05)
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
            leftRotate.toValue = CGFloat(M_PI * -0.05)
            leftRotate.duration = animateDuration
            
            totalDuration += animateDuration
            
            lastReturnRotate = CABasicAnimation(keyPath: "transform.rotation")
            lastReturnRotate.beginTime = beginTime + totalDuration
            lastReturnRotate.fromValue = leftRotate.toValue
            lastReturnRotate.toValue = CGFloat(0)
            lastReturnRotate.duration = animateDuration
            lastReturnRotate.delegate = self
            
            totalDuration += animateDuration
            
            self.fortuneCookieViewImg.layer.addAnimation(rightRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.addAnimation(returnRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.addAnimation(leftRotate, forKey: nil)
            self.fortuneCookieViewImg.layer.addAnimation(lastReturnRotate, forKey: nil)
        }
        
        if (showFortune) {
            let triggerTimeSeconds = (Int64(NSEC_PER_SEC) * Int64(totalDuration - 1))
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTimeSeconds), dispatch_get_main_queue(), { () -> Void in
                self.fortunesModel!.makeFortune()
            })
        }
    }
}
