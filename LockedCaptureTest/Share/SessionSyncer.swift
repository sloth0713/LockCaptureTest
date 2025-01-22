//
//  SessionSyncer.swift
//  LockedCameraCaptureSample
//
//  Created by ByteDance on 2025/1/17.
//

import AVFoundation
import Photos
import LockedCameraCapture
import UIKit

enum CamearCaptureType: String {
    case App
    case Extension
}

class SessionSyncer {
    let sessionContentURL:URL
    let camearCaptureType:CamearCaptureType
    
    init(sessionContentURL:URL, camearCaptureType:CamearCaptureType) {
        self.sessionContentURL = sessionContentURL
        self.camearCaptureType = camearCaptureType
    }
    
    convenience init(camearCaptureType:CamearCaptureType) {
        self.init(sessionContentURL:SessionSyncer.getStandardRootURL(), camearCaptureType:camearCaptureType)
    }
    
    static private func getStandardRootURL() -> URL {
        if let libraryDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
            return libraryDirectoryURL
        }
        return URL(fileURLWithPath: "sss")
    }
    
    static func initAppContext() {
        let appContext = CaptureIntent.AppContext(UIState:"UIState1")
        Task {
            do {
                try await CaptureIntent.updateAppContext(appContext)
                print("app context updated")
            } catch {
                print("error on updating app context \(error)")
            }
        }
    }
}
