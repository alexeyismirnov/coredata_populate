//
//  HostingController.swift
//  iwatch Extension
//
//  Created by Alexey Smirnov on 3/8/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        print(path)
    }
    
    override var body: AnyView {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        return AnyView(ContentView().environment(\.managedObjectContext, context))
    }
}
