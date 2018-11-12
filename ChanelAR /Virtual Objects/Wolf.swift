//
//  Wolf.swift
//  ARKitExample
//
//  Created by subramanya on 18/07/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
class Wolf: VirtualObject {
    
    override init() {
        super.init(modelName: "wolf", fileExtension: "dae", thumbImageFilename: "vase", title: "wolf")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
