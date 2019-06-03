//
//  Category.swift
//  Jobbies
//
//  Created by Joseph McCraw on 6/3/19.
//  Copyright © 2019 Joseph McCraw. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic  var name: String = ""
    @objc dynamic var createdOn: Date = Date()
    let items = List<Item>()
    
}
