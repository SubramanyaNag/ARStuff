//
//  Candle.swift
//  ARKitExample
//
//  Created by Subramanya on 18/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

class Candle: VirtualObject, ReactsToScale {
	
	override init() {
		super.init(modelName: "candle", fileExtension: "scn", thumbImageFilename: "candle", title: "Candle")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func reactToScale() {
		// Update the size of the flame
		let flameNode = self.childNode(withName: "flame", recursively: true)
		let particleSize: Float = 0.018
		flameNode?.particleSystems?.first?.reset()
		flameNode?.particleSystems?.first?.particleSize = CGFloat(self.scale.x * particleSize)
	}
}
