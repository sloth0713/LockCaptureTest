//
//  CaptureIntent.swift
//  LockedCaptureTest
//
//  Created by ByteDance on 2025/1/20.
//

import LockedCameraCapture
import AppIntents

struct CaptureIntent: CameraCaptureIntent {
    static var title: LocalizedStringResource = "CaptureIntent"
    
    @MainActor
    func perform() async throws -> some IntentResult {
        //update AppContext
        return .result()
    }
}
