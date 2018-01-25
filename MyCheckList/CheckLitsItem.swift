//
//  CheckLitsItem.swift
//  MyCheckList
//
//  Created by Student on 2018-01-17.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class CheckLitsItem: NSObject, Codable {
    
    var text = ""
    var checked = false
    
    init(text: String, Checked: Bool){
        
        self.text = text
        self.checked = Checked

}
}
