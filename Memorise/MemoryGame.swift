//
//  MemoriseGame.swift
//  Memorise
//
//  Created by Jose Espejo on 11/07/2024.
//
//  Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // Add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only } // .only is a custom extension - see bottom of file
        
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                        
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        
        var debugDescription: String {
                    "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
                }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
