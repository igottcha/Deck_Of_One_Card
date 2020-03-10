//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Chris Gottfredson on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static let drawCardURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let drawCardURL = drawCardURL else { return completion(.failure(.invalidURL))}
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: drawCardURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // 4 - Check for json data
            guard let data = data else { return completion(.failure(.noData))}
            
            // 5 - Decode json into a Card
            do {
                let decoder = JSONDecoder()
                let topLevelObject = try decoder.decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.noData)) }
                return completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
            }
        } .resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        // 1 - Prepare URL
        let cardImageURL = card.image
        print(cardImageURL)
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: cardImageURL) { (data, _, error) in
            
            // 3 - Handle errors from the server
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // 4 - Check for image data
            guard let data = data else { return completion(.failure(.noData))}
            
            // 5 - Initialize an image from the data
            guard let cardImage = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            return completion(.success(cardImage))
        }.resume()
    }
    
}
