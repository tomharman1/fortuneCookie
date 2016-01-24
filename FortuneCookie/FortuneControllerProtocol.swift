//
//  FortuneControllerProtocol.swift
//  MrFortuneCookie
//
//  Created by Thomas Harman on 5/14/16.
//  Copyright © 2016 Toms Apps. All rights reserved.
//

import Foundation

protocol FortuneControllerProtocol {
    func showGreedyMessage(greedyMessage: String)
    func showFortune(fortune: String)
    func showRanOutOfFortunes(fortune: String)
}