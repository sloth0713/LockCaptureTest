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
            VStack {
                CaptureView(sessionSyncer:SessionSyncer(sessionContentURL: session.sessionContentURL, camearCaptureType: .Extension))
                //没有就权限就删除
                
//                Text("You have denied Photo Library or Camera permission, please grant them in the system's settings.")
                
                //快速移动文件位置
                
                Button(action:{
                        Task {
                            do {
                                try await session.openApplication(for: NSUserActivity(activityType: NSUserActivityTypeLockedCameraCapture))
                            } catch {
                                print("open main app error: \(error.localizedDescription)")
                            }
                        }
                    }){
                        Text("open main app")
                    }
                }
        }
    }
}
    
