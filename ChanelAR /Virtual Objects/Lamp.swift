//
//  Lamp.swift
//  ARKitExample
//
//  Created by Subramanya on 18/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import ARKit

class Lamp: VirtualObject {
	
	override init() {
		super.init(modelName: "lamp", fileExtension: "scn", thumbImageFilename: "lamp", title: "Lamp")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
