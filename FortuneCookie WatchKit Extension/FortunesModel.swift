//
//  FortunesModel.swift
//  FirstWatchApp
//
//  Created by Thomas Harman on 7/12/15.
//  Copyright © 2015 Toms Apps. All rights reserved.
//

import WatchKit

class FortunesModel {

    let RAN_OUT_OF_FORTUNES_STR = "You ran out of Fortunes!"

    let nsDataFacade = NSDataFacade()
    let maxLengthFortuneSupported = 63
    var currentFortuneIndex = -1

    func getFortune() -> String? {
        while(isHaveAFortuneToShow()) {
            let i = getRandomIndex()
            let fortune = self.fortunes[i]
            if (isValidFortune(i)) {
                nsDataFacade.sawFortuneWithIndex(i)
                print("showing fortune: \(i)")
                return fortune
            }
            else {
                print("couldn't find a fortune on this attempt! (length: \(fortune.characters.count), index: \(i))")
            }
            currentFortuneIndex = i
        }
        return self.RAN_OUT_OF_FORTUNES_STR
    }
    
    func getRandomIndex() -> Int {
        var index = -1
        if (currentFortuneIndex == -1) {
            index = random()
        }
        else {
            index = currentFortuneIndex + 1
        }
        return (index % fortunes.count)
    }

    func getLastShownFortune() -> String {
        return getFortuneWithIndex(nsDataFacade.lastShownFortuneIndex())
    }

    private func getFortuneWithIndex(i: Int) -> String {
        return fortunes[i]
    }
    
    private func isHaveAFortuneToShow() -> Bool {
        return nsDataFacade.seenFortunesCount() < fortunes.count
    }
    
    private func isValidFortune(i: Int) -> Bool {
        let fortuneLength = self.fortunes[i].characters.count
        return (i != currentFortuneIndex) &&
                (fortuneLength < maxLengthFortuneSupported) &&
                    !nsDataFacade.isHaveAlreadySeenFortuneWithIndex(i)
    }
    
    let fortunes: [String] = ["A smile is your passport into the hearts of others.",
        "A good way to keep healthy is to eat more Chinese food.",
        "Your high-minded principles spell success.",
        "Hard work pays off in the future, laziness pays off now.",
        "Change can hurt, but it leads a path to something better.",
        "Enjoy the good luck a companion brings you.",
        "People are naturally attracted to you.",
        "A chance meeting opens new doors to success and friendship.",
        "You learn from your mistakes... You will learn a lot today.",
        "If you have something good in your life, don't let it go!",
        "Your shoes will make you happy today.",
        "You cannot love life until you live the life you love.",
        "Land is always on the mind of a flying bird.",
        "The man or woman you desire feels the same about you.",
        "Meeting adversity well is the source of your strength.",
        "A dream you have will come true.",
        "Our deeds determine us, as much as we determine our deeds.",
        "Never give up. You're not a failure if you don't give up.",
        "You will become great if you believe in yourself.",
        "You will marry your lover.",
        "A very attractive person has a message for you.",
        "It is now, and in this world, that we must live.",
        "You must try, or hate yourself for not trying.",
        "You can make your own happiness.",
        "The greatest risk is not taking one.",
        "Love can last a lifetime, if you want it to.",
        "Adversity is the parent of virtue.",
        "Now is the time to try something new.",
        "If winter comes, can spring be far behind?",
        "A stranger, is a friend you have not spoken to yet.",
        "Conquer your fears or they will conquer you.",
        "You learn from your mistakes, you will learn a lot today.",
        "Rivers need springs.",
        "Good news from afar may bring you a welcome visitor.",
        "Happiness is often a rebound from hard work.",
        "Do not fear what you don't know",
        "The object of your desire comes closer.",
        "If you wish to know the mind of a man, listen to his words",
        "Back away from individuals who are impulsive.",
        "Enjoyed the meal? Buy one to go too.",
        "You believe in the goodness of mankind.",
        "A big fortune will descend upon you this year.",
        "For success today look first to yourself.",
        "Determination is the wake-up call to the human will.",
        "A merry heart does good like a medicine.",
        "Whenever possible, keep it simple.",
        "Your dearest wish will come true.",
        "Poverty is no disgrace.",
        "Land is always in the mind of the flying birds.",
        "Try? No! Do or do not, there is no try.",
        "It's about time you asked that special someone on a date.",
        "You create your own stage ... the audience is waiting.",
        "It is never too late. Just as it is never too early.",
        "Discover the power within yourself.",
        "Good things take time.",
        "Put your unhappiness aside. Life is beautiful, be happy.",
        "You can still love what you can not have in life.",
        "Make a wise choice everyday.",
        "If you never expect anything you can never be disappointed.",
        "If you speak honestly, everyone will listen.",
        "Ganerosity will repay itself sooner than you imagine.",
        "good things take time",
        "Do what is right, not what you should.",
        "To effect the quality of the day is no small achievement.",
        "Simplicity and clearity should be the theme in your dress.",
        "Not all closed eye is sleeping, nor open eye is seeing.",
        "Bread today is better than cake tomorrow.",
        "In evrything there is a piece of truth.But a piece.",
        "A feeling is an idea with roots.",
        "Man is born to live and not prepare to live",
        "If you don t give something, you will  not get anything",
        "It's up to you to clearify.",
        "Your future will be happy and productive.",
        "Seize every second of your life and savor it.",
        "Those who walk in other's tracks leave no footprints.",
        "Failure is the mother of all success.",
        "Difficulty at the beginning useually means ease at the end.",
        "Friendship is an ocean that you cannot see bottom.",
        "A pleasant expeience is ahead:don't pass it by.",
        "They say you are stubborn; you call it persistence.",
        "You will prosper in the field of wacky inventions.",
        "Your tongue is your ambassador.",
        "The cure for grief is movement.",
        "Love Is At Your Hands Be Glad And Hold On To It.",
        "You are often asked if it is in yet.",
        "Life to you is a bold and dashing responsibility.",
        "Patience is a key to joy.",
        "Today is going to be a disasterous day, be prepared!",
        "Stay to your inner-self, you will benefit in many ways.",
        "You are talented in many ways.",
        "You are the master of every situation.",
        "Your problem just got bigger. Think, what have you done.",
        "Your fortune is as sweet as a cookie.",
        "Get off to a new start - come out of your shell.",
        "Life is a dancefloor,you are the DJ!",
        "Cooperate with those who have both know how and integrith.",
        "Your mouth may be moving, but nobody is listening.",
        "Focus in on the color yellow tomorrow for good luck!",
        "All your sorrows will vanish.",
        "About time I got out of that cookie.",
        "Love will lead the way.",
        "The ads revenge is massive success",
        "Soon, a visitor shall delight you.",
        "What breaks in a moment may take years to mend.",
        "You will be rewarded for your patience and understanding.",
        "You will achieve all your desires and pleasures.",
        "Never miss a chance to keep your mouth shut.",
        "Never regret anything that made you smile.",
        "Love Takes Pratice.",
        "Don't take yourself so seriously, no one else does.",
        "At this very moment you can change the rest of your life.",
        "Become who you are.",
        "All comes at the proper time to him who knows how to wait.",
        "The energy is within you. Money is Coming!",
        "You have an important new business development shaping up.",
        "WHEN FIRE AND WATER GO TO WAR WATER ALWAYS WINS.",
        "An angry man opens his mouth and shuts up his eyes.",
        "Make the system work for you, not the other way around.",
        "You will be hungry soon, order takeout now.",
        "Be prepared for extra energy.",
        "An unexpected relationship will become permanent.",
        "The love of your life is sitting across from you.",
        "Better be the head of a chicken than the tail of an ox.",
        "Enjoy yourself while you can.",
        "What ends on hope does not end at all.",
        "People enjoy having you around. Appreciate this.",
        "Help, I'm prisoner in a Chinese bakery!!!",
        "If everybody is a worm you should be a glow worm",
        "To affirm is to make firm.",
        "You broke my cookie!",
        "Failure is not defeat until you stop trying.",
        "The days that make us happy make us wise.",
        "Men do not fail... they give up trying.",
        "Time may fly by. But Memories don't.",
        "You will win success in whatever you adopt.",
        "You will outdistance all your competitors.",
        "AT TIMES IT IS BETTER TO KNOW WHEN EXIT THAN ENTER",
        "You'll advance for with your abilities.",
        "You will overcome difficult times.",
        "The majority of the word \"can't\" is can.",
        "The secret of getting ahead is getting started.",
        "Be most affectionate today.",
        "Change your thoughts and you change the world.",
        "Sing and rejoice, fortune is smiling on you.",
        "All the preparation you've done will finally be paying off!",
        "Those grapes you cannot taste are always sour.",
        "Be patient: in time, even an egg will walk.",
        "You are not a person who can be ignored.",
        "Reading to the mind is what exercise is to the body.",
        "Eat something you never tried before.",
        "Your life becomes more and more of an adventure!",
        "You need to live authentically, and you can't ignore that.",
        "Make all you can, save all you can, give all you can.",
        "A well-aimed spear is worth three.",
        "To build a better world, start in your community.",
        "May you have great luck.",
        "A kind word will keep someone warm for years.",
        "Nothing in the world is accomplished without passion.",
        "Human invented language to satisfy the need to complain.",
        "The best way to give credit is to give it away.",
        "It takes more then good memory to have good memories.",
        "Grant yourself a wish this year only you can do it.",
        "love thy neighbour, just don't get caught",
        "You will inherit a large sum of money.",
        "You will recieve a gift from someone that cares about you.",
        "You are not illiterate.",
        "Love because it is the only true adventure.",
        "Keep true to the dreams of your youth.",
        "Treasure what you have.",
        "The greatest precept is continual awareness.",
        "A new friend helps you break out of an old routine.",
        "I have a dream.... Time to go to bed.",
        "Your skill will accomplish what the force of many cannot.",
        "You will soon be surrounded by good friends and laughter.",
        "The best is yet to come.",
        "It is better to be the hammer then the anvil.",
        "He who climbs a ladder must begin at the first step.",
        "Action speaks nothing, without the Motive.",
        "Live each day well and wisely",
        "You have a curious smile and a mysterious nature",
        "Your succeess will astonish everyone.",
        "It is better to have a hen tomorrow than an egg today.",
        "You like Chinese food.",
        "Your hard work will get payoff today.",
        "Today is the tomorrow we worried about yesterday",
        "There are no shortcuts to any place worth going",
        "Soon you will be sitting on top of the world.",
        "You are never selfish with your advice or your help.",
        "A thrilling time is in store for you.",
        "It's tough to be fascinating.",
        "Soon life will become more interesting",
        "You are cautious in showing your true self to others.",
        "Your ability to accomplish tasks will follow with success.",
        "You will have a bright future.",
        "Compassion is a way of being.",
        "You will always have good luck in your personal affairs.",
        "The pleasure of what we enjoy is lost by wanting more",
        "Did you remember to order your take out also?",
        "Perhaps you've been focusing too much on that one thing..",
        "Right now there's an energy pushing you in a new direction.",
        "Everybody feels lucky for having you as a friend.",
        "When the moment comes, take  the top one.",
        "There is always a way - if you are committed.",
        "Life is too short to waste time hating anyone."]
}
