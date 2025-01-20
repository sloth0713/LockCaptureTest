//
//  WidgetExtensionControl.swift
//  WidgetExtension
//
//  Created by ByteDance on 2025/1/20.
//

import AppIntents
import SwiftUI
import WidgetKit

struct WidgetExtensionControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: "LockedCameraCaptureTest.Widget") {
            ControlWidgetButton(action: CaptureIntent()) {
                Label("LockedCapture", systemImage: "camera.viewfinder")
            }
        }
    }
}
