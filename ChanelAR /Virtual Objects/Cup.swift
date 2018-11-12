//
//  Cup.swift
//  ARKitExample
//
//  Created by Subramanya on 18/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

class Cup: VirtualObject {
	
	override init() {
		super.init(modelName: "cup", fileExtension: "scn", thumbImageFilename: "cup", title: "Cup")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
