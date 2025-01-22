//
//  ContentView.swift
//  LockedCameraCaptureTest
//
//  Created by Photon Juniper on 2024/8/20.
//

import SwiftUI
import AVFoundation
import LockedCameraCapture

struct ContentView: View {
    
    @State var imageValues: [UIImage] = []
    
    var mainCaptureView:MainCaptureView =  MainCaptureView(sessionSyncer: SessionSyncer(camearCaptureType:.App))
    
    var body: some View {
        VStack {
            self.mainCaptureView
        }
        .onAppear {
            Task {
                let _ = await AVCaptureDevice.requestAccess(for: .video)
            }
        }
        .onContinueUserActivity(NSUserActivityTypeLockedCameraCapture) { NSUserActivity in
            print("open by NSUserActivityTypeLockedCameraCapture")
            self.mainCaptureView.refreshFromAppContext()
            
        }
    }
    
    private func getLockedCaptureImage() {
        for url in LockedCameraCaptureManager.shared.sessionContentURLs {
            let fileUrl = url.appendingPathComponent("LockedCapture")
            do {
                let data = try Data(contentsOf: fileUrl)
                guard let uiImage = UIImage(data: data) else { return }
                imageValues.append(uiImage)
            } catch {
                // error handling
            }
        }
    }
}
