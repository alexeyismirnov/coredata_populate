//
//  CardView.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 3/10/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import SwiftUI
import CoreData

struct CardView: View {
    @Environment(\.managedObjectContext) var context

    var list: ListEntity
    @State var cards: [CardEntity] = []
        
    init(_ list: ListEntity) {
        self.list = list
        
        let request = NSFetchRequest<CardEntity>()
        request.entity = CardEntity.entity()
        request.predicate = NSPredicate(format: "list.id == %@", list.id! as CVarArg)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CardEntity.objectID, ascending: true)]

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let cards = try! context.fetch(request)

        self._cards = State(initialValue: cards)
    }
    
    var body: some View {
        List {
            ForEach(cards, id: \.id) { card in
                VStack(alignment: .leading) {
                    Text((card as CardEntity).wordTrad!).font(.title)
                    Text((card as CardEntity).pinyin!)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(ListEntity())
    }
}
