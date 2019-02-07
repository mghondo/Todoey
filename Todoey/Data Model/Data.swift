//
//  Data.swift
//  Todoey
//
//  Created by Morgan Hondros on 2/7/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
