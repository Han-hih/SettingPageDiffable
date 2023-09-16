//
//  Hashable.swift
//  SettingPageDiffable
//
//  Created by 황인호 on 2023/09/15.
//

import UIKit

struct Table: Hashable {
    
    let title: String
    let secondTitle: String
    let image: String
    let color: UIColor
    
    init(title: String, secondTitle: String, image: String, color: UIColor) {
        self.title = title
        self.secondTitle = secondTitle
        self.image = image
        self.color = color
    }
    
}
