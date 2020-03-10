//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Chris Gottfredson on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

struct Card: Decodable {
    
    let value: String
    let suit: String
    let image: URL
}

struct TopLevelObject: Decodable {
    
    let cards: [Card]
}
