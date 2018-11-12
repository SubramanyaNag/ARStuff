//
//  Vase.swift
//  ARKitExample
//
//  Created by Subramanya on 18/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Vase: VirtualObject {
	
	override init() {
		super.init(modelName: "vase", fileExtension: "scn", thumbImageFilename: "vase", title: "Vase")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
