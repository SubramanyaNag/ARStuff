//
//  Bag 2.swift
//  ARKitExample
//
//  Created by Subramanya on 19/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Handbag: VirtualObject {
    
    override init() {
        super.init(modelName: "handbag", fileExtension: "dae", thumbImageFilename: "bag", title: "Handbag")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
