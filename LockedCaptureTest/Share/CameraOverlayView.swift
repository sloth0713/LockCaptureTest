//
//  CameraOverlayView.swift
//  LockedCaptureTest
//
//  Created by ByteDance on 2025/1/20.
//

import UIKit

class CameraOverlayView: UIView {
    
    var button: UIButton!
    public var UIState:String = "UIState1"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        self.syncRefreshFromAppContext()
    }
    
    private func setupButton() {
        self.button = UIButton(type: .system)
        self.button.setTitle(self.UIState, for: .normal)
        self.button.backgroundColor = UIColor.green
        self.button.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.addSubview(button)
        
        self.syncRefreshFromAppContext()
    }
    
    @objc func buttonTapped() {
        
        guard let currentTitle = self.button.currentTitle, !currentTitle.isEmpty else {
            return
        }
        
        var newTitle:String = "UIState1"
        
        if (currentTitle == "UIState1") {
            newTitle = "UIState2"
        }
        
        self.button.setTitle(newTitle, for: .normal)
        
        let appContext = CaptureIntent.AppContext(UIState:newTitle)
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

extension CameraOverlayView {
    func refreshFromAppContext() async {
        do {
            if let appContext = try await CaptureIntent.appContext {
                let UIState:String = appContext.UIState
                DispatchQueue.main.async {
                    self.button.setTitle(UIState, for: .normal)
                }
            }
        } catch {
            print("error on getting app context")
        }
        
    }
    
    func syncRefreshFromAppContext() {
        Task {
            await refreshFromAppContext()
        }
    }
}
