//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Chris Gottfredson on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        cardLabel.layer.cornerRadius = 10
        cardLabel.layer.borderWidth = 2
        cardLabel.layer.masksToBounds = true
        drawButton.layer.cornerRadius = 20
        drawButton.layer.borderWidth = 2
    }
    
    //MARK: - Action
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchCardAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchCardAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.cardLabel.text = "\(card.value) of \(card.suit)"
                    self.cardImageView.image = image
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }
    
}
