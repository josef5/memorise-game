//
//  MemoriseApp.swift
//  Memorise
//
//  Created by Jose Espejo on 09/07/2024.
//

import SwiftUI

@main
struct MemoriseApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
