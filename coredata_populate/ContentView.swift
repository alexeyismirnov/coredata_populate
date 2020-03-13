//
//  ContentView.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 3/3/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(entity: CardEntity.entity(), sortDescriptors: []) var cardsResults: FetchedResults<CardEntity>
    @FetchRequest(entity: ListEntity.entity(), sortDescriptors: []) var listsResults: FetchedResults<ListEntity>

    var body:  AnyView {
        
        let content = VStack {
            Button(action: {
                for deck in lists {
                    let list1 = ListEntity(context: self.context)
                    list1.id = UUID()
                    list1.name = deck.name
                    list1.wordCount = Int32(deck.wordCount)
                    
                    try! self.context.save()

                    let cards: [VocabCard] = deck.loadCSV()

                    for card in cards {
                        let card1 = CardEntity(context: self.context)
                        card1.id = UUID()
                        card1.wordSimp = card.wordSimp
                        card1.wordTrad = card.wordTrad
                        card1.pinyin = card.pinyin
                        card1.translation = card.translation
                        card1.list = list1
                        
                        try! self.context.save()
                    }
                }
                
                
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle")
                    Text("Populate")
                }
            }.padding(10)
            
            NavigationLink(destination: ListView()) {
                HStack {
                    Image(systemName: "arrow.right.circle")
                    Text("View")
                }
            }.padding(10)
            
            Button(action: {
                for card in self.cardsResults {
                    self.context.delete(card)
                }
                
                for list in self.listsResults {
                    self.context.delete(list)
                }
                
                try! self.context.save()
                
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle")
                    Text("Delete")
                }
            }
        }
        
        #if os(watchOS)
        return AnyView(content)
        #else
        return AnyView(NavigationView { content })
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
