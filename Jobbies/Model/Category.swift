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
    let items = List<Item>()
    
}
