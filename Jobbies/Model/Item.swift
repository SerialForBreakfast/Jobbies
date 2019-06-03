//
//  Item.swift
//  Jobbies
//
//  Created by Joseph McCraw on 6/3/19.
//  Copyright © 2019 Joseph McCraw. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
