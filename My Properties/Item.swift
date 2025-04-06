//
//  Item.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 5/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
