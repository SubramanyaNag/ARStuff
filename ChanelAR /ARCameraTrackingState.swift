//
//  ARCameraTrackingState.swift
//  ARKitExample
//
//  Created by Subramanya on 19/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import ARKit

extension ARCamera.TrackingState {
    var presentationString: String {
        switch self {
        case .notAvailable:
            return "TRACKING UNAVAILABLE"
        case .normal:
            return "TRACKING NORMAL"
        case .limited(let reason):
            switch reason {
            case .excessiveMotion:
                return "TRACKING LIMITED\nToo much camera movement"
            case .insufficientFeatures:
                return "TRACKING LIMITED\nNot enough surface detail"
            case .initializing:
                return "INITIALIZING"
            }
        }
    }
}

