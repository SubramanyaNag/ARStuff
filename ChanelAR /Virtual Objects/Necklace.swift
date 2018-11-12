//
//  Necklace.swift
//  ChanelAR
//
//  Created by subramanya on 02/01/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

class Necklace: VirtualObject {
    
    override init() {
        super.init(modelName: "Necklace", fileExtension: "dae", thumbImageFilename: "vase", title: "Necklace")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpiderNecklace: VirtualObject {
    
    override init() {
        super.init(modelName: "Spider Necklace", fileExtension: "dae", thumbImageFilename: "spider", title: "Spider Necklace")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
