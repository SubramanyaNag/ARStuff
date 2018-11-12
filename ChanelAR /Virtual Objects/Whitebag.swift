//
//  WhiteBag.swift
//  ARKitExample
//
//  Created by Subramanya on 18/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class WhiteBag: VirtualObject {
    
    override init() {
        super.init(modelName: "WhiteBag", fileExtension: "dae", thumbImageFilename: "bag", title: "White Bag")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
