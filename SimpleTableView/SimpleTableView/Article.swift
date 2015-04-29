//
//  Article.swift
//  Englogram
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/3/15.
//  Copyright (c) 2015 Mussayev Temirulan. All rights reserved.
//

import Foundation

class Article: Printable {
    var id: String
    var name: String
    var title: String
    var content: String
    var date: String
    var category: String
    var status: Bool
    
    init(id: String, name: String, title: String, content: String, date: String, category: String, status: Bool) {
        self.id = id
        self.name = name
        self.title = title
        self.content = content
        self.date = date
        self.category = category
        self.status = status
    }
    
    internal var description: String {
        return "title: \(title); content: \(content); category: \(category)"
    }
}
