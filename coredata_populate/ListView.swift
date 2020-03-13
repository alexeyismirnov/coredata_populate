//
//  ListView.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 3/10/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import SwiftUI
import CoreData

struct ListView: View {
    @State var lists: [ListEntity] = []

    init() {
        let request = NSFetchRequest<ListEntity>()
        request.entity = ListEntity.entity()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ListEntity.objectID, ascending: true)]
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let lists = try! context.fetch(request)
        
        self._lists = State(initialValue: lists)
    }
    
    var body: some View {
        List {
            ForEach(lists, id: \.id) { list in
                NavigationLink(destination: CardView(list)) {
                    Text((list as ListEntity).name!)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
