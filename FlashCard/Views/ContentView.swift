/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view that contains the majority of the app's content.
*/

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var cards: [Card] // use query to display models managed by SwiftData in the UI
    @State private var editing = false
    @State private var navigationPath: [Card] = []
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack(path: $navigationPath) {
            CardGallery(cards: cards, editing: $editing) { card in
                withAnimation { navigationPath.append(card) }
            } addCard: {
                let newCard = Card(front: "Sample Front", back: "Sample Back")
                modelContext.insert(newCard) // save card
                withAnimation {
                    navigationPath.append(newCard)
                    editing = true
                }
            }
            .padding()
            .toolbar { EditorToolbar(isEnabled: false, editing: $editing) }
        }
    }
}

#Preview {
    ContentView()
        .frame(minWidth: 500, minHeight: 500)
        .modelContainer(previewContainer)
}
