//
//  MainCaptureView.swift
//  LockedCameraCaptureSample
//
//  Created by ByteDance on 2025/1/17.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers
import LockedCameraCapture
import Photos

struct MainCaptureView: View {
    
    let captureView:CaptureView
    init(sessionSyncer:SessionSyncer) {
        self.captureView = CaptureView(sessionSyncer: sessionSyncer)
    }
    
    var body: some View {
        VStack {
            self.captureView
            
            if self.captureView.sessionSyncer.camearCaptureType == .Extension {
                Text("You have denied Photo Library or Camera permission, please grant them in the system's settings.")
                //快速移动文件位置
                
                Button(action: {
                    
                }) {
                    Text("open main app")
                }
                
            }
            
        }
    }
}
//需要用户许可NSCameraUsageDescription
struct CaptureView: UIViewControllerRepresentable {
    private let delegate: ImagePickerDelegate
    let sessionSyncer:SessionSyncer
    
    init(sessionSyncer:SessionSyncer) {
        self.sessionSyncer = sessionSyncer
        self.delegate = ImagePickerDelegate(sessionSyncer: sessionSyncer)
    }
    
    func makeUIViewController(context: Self.Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]
        imagePicker.cameraDevice = .rear
        imagePicker.delegate = self.delegate
        
        imagePicker.videoQuality = .typeHigh
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Self.Context) {
        
    }
}

private class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let sessionSyncer:SessionSyncer
    
    init(sessionSyncer:SessionSyncer) {
        self.sessionSyncer = sessionSyncer
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //拍摄完成后选择用这个照片
        
        
        if let videoURL = info[.mediaURL] as? URL {
            // 处理录制的视频
            saveVideoToLibrary(videoURL)
            return
        }
        
        
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        do {
            let rootURL:URL = self.sessionSyncer.sessionContentURL
            let fileURL = rootURL.appendingPathComponent("appCapture")
            try pickedImage.jpegData(compressionQuality: 0.7)?.write(to: fileURL)

            print("success save url \(rootURL.absoluteString)")
            
        } catch {
            debugPrint(error)
        }
        
    }
    
    func saveVideoToLibrary(_ videoURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }) { success, error in
            if success {
                print("视频保存成功")
            } else {
                if let error = error {
                    print("视频保存失败: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
    }

}
