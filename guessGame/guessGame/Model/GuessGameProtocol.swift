//
//  GuessGameProtocol.swift
//  guessGame
//
//  Created by Tolgay Dulger on 17.10.2021.
//

import Foundation

protocol GuessGameProtocol: AnyObject {
    func resetUI()
    func throwLastChanceWarning()
    func enterNumberWarning()
}
