//
//  CardView.swift
//  Memorise
//
//  Created by Jose Espejo on 16/07/2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let cornerRadius = CGFloat(12)
        static let lineWidth = CGFloat(2)
        static let inset = CGFloat(5)
        
        struct FontSize {
            static let largest = CGFloat(200)
            static let smallest = CGFloat(10)
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity = CGFloat(0.5)
            static let inset = CGFloat(5)
        }
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    typealias Card = CardView.Card
   
    return VStack {
        HStack{
            CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                .aspectRatio(4/3, contentMode: .fit)
            CardView(Card(content: "X", id: "test2"))
        }
        HStack{
            CardView(Card(isFaceUp: true, isMatched: true, content: "A very long string blah blah blah blah", id: "test3"))
            CardView(Card(isMatched: true, content: "X", id: "test4"))
        }
    }
    .padding()
    .foregroundColor(.blue)
}
