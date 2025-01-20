//
//  CaptureExtension.swift
//  CaptureExtension
//
//  Created by ByteDance on 2025/1/20.
//

import Foundation
import LockedCameraCapture
import SwiftUI

@main
struct CaptureExtension: LockedCameraCaptureExtension {
    var body: some LockedCameraCaptureExtensionScene {
        LockedCameraCaptureUIScene { session in
            MainCaptureView(sessionSyncer:SessionSyncer(sessionContentURL: session.sessionContentURL, camearCaptureType: .Extension))
        }
    }
}
