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
    
    struct MyAppContext: Codable {
        var UIState: String = "UIState1"
    }
    typealias AppContext = MyAppContext
    
    @MainActor
    func perform() async throws -> some IntentResult {
        //update AppContext
        print("CameraCaptureIntent")
        return .result()
    }
}
