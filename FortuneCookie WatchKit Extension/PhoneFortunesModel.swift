//
//  PhoneFortunesModel.swift
//  MrFortuneCookie
//
//  Created by Thomas Harman on 5/8/16.
//  Copyright © 2016 Toms Apps. All rights reserved.
//

import Foundation

class PhoneFortunesModel: FortunesModel {
    
    var phoneFortunes = [""]
    
    override init(fortuneController: FortuneControllerProtocol) {
        super.init(fortuneController: fortuneController)
        var fortunes = super.getFortunes()
        fortunes.append(contentsOf: getPhoneFortunes())
        self.phoneFortunes = fortunes
    }
    
    override func getMaxSupportedFortuneLength() -> Int {
        return 140 // TODO - test some big fortunes out
    }
    
    override func getFortunes() -> [String] {
        return phoneFortunes
    }
    
    fileprivate func getPhoneFortunes() -> [String] {
        return ["If you refuse to accept anything but the best, you very often get it.",
                "Hidden in a valley beside an open stream- This will be the type of place where you will find your dream.",
                "What ever you're goal is in life, embrace it visualize it, and for it will be yours.",
                "Be on the lookout for coming events; They cast their shadows beforehand.",
                "There is no greater pleasure than seeing your loved ones prosper.",
                "You already know the answer to the questions lingering inside your head.",
                "The love of your life is stepping into your planet this summer.",
                "You only need look to your own reflection for inspiration. Because you are Beautiful!",
                "You are not judged by your efforts you put in; you are judged on your performance.",
                "When all else seems to fail, smile for today and just love someone.",
                "If you are afraid to shake the dice, you will never throw a six.",
                "A single conversation with a wise man is better than ten years of study.",
                "The world may be your oyster, but that doesn't mean you'll get it's pearl.",
                "You're true love will show himself to you under the moonlight.",
                "Do not follow where the path may lead.  Go where there is no path...and leave a trail",
                "The most useless energy is trying to change what and who God so carefully created.",
                "Do not be covered in sadness or be fooled in happiness they both must exist",
                "Intelligence is the door to freedom and alert attention is the mother of intelligence.",
                "Now these three remain, faith, hope, and love. The greatest of these is love.",
                "There are no limitations to the mind except those we aknowledge.",
                "If you don&amp;rsquo;t do it excellently, don&amp;rsquo;t do it at all.",
                "Stop thinking about the road not taken and pave over the one you did.",
                "Circumstance does not make the man; it reveals him to himself.",
                "The man who waits till tomorrow, misses the opportunities of today.",
                "Life does not get better by chance. It gets better by change.",
                "In music, one must think with his heart and feel with his brain.",
                "Virtuous find joy while Wrongdoers find grieve in their actions.",
                "It's all right to have butterflies in your stomach. Just get them to fly in formation.",
                "Do not seek so much to find the answer as much as to understand the question better.",
                "Your way of doing what other people do their way is what makes you special.",
                "A beautiful, smart, and loving person will be coming into your life.",
                "Your life does not get better by chance, it gets better by change.",
                "Our duty,as men and women,is to proceed as if limits to our ability did not exist.",
                "Our perception and attitude toward any situation will determine the outcome",
                "IT IS NOT GOOD TO BE A USER BLESSINGS COME FROM BEING A GIVER NOT A TAKER.",
                "A bargain is something you don't need at a price you can't resist.",
                "Rarely do great beauty and great virtue dwell together as they do in you.",
                "It is much easier to look for the bad, than it is to find the good",
                "If a person who has caused you pain and suffering has brought you, reconsider that person's value in your life",
                "You are worth loving, you are also worth the effort it takes to love you",
                "You are about to become $8.95 poorer. ($6.95 if you had the buffet)",
                "The problem with resisting temptation is that it may never come again.",
                "It is best to act with confidence, no matter how little right you have to it.",
                "Take control of your life rather than letting things happen just like that!",
                "You've got what it takes, but it will take everything you've got!",
                "The quotes that you do not understand, are not meant for you.",
                "To forgive others one more time is to create one more blessing for yourself.",
                "The ultimate test of a relationship is to disagree but to hold hands.",
                "Excellence is the difference between what I do and what I am capable of.",
                "Do not let what you do not have prevent you from using what you do have.",
                "Take a minute and let it ride, then take a minute to let it breeze.",
                "We are here to love each other, serve each other and uplift each other.",
                "Remember this: duct tape can fix anything, so don't worry about messing things up.",
                "You have a great capability to break cookies - use it wisely!",
                "When you can't naturally feel upbeat it can sometimes help you to act as if you did.",
                "Your problem just became your stepping stone.  Catch the moment.",
                "I am a fortune. You just broke my little house. Where will i live now?",
                "A truly great person never puts away the simplicity of a child.",
                "Customer service is like taking a bath you have to keep doing it.",
                "The expanse of your intelligence is a void no universe could ever fill.",
                "You always know the right times to be assertive or to simply wait.",
                "When you can't naturally feel upbeat, it can sometimes help to act a if you did.",
                "Anything you do, do it well. The last thing you want is to be sorry for what you didn't do.",
                "You will be selected for a promotion because of your accomplishments.",
                "There are many new opportunities that are being presented to you.",
                "You  are  contemplating  some  action  which will bring credit upon you",
                "Judge each day not by the harvest you reap but by the seeds you plant.",
                "No matter what your past has been, you have a spotless future.",
                "Your secret desire to completely change your life will manifest.",
                "We all have extraordinary coded within us, waiting to be released.",
                "Sometimes travel to new places leads to great transformation."]
    }
}
