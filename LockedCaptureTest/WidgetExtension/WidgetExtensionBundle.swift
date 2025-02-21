//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by ByteDance on 2025/1/20.
//

import WidgetKit
import SwiftUI

@main
struct WidgetLauncher {
    static func main() {
        
        if widgetEnable {
            WidgetExtensionBundle.main()
        }else {
            EmptyWidget.main()
        }

    }
    
    static var widgetEnable: Bool {
        
        let random = Double(Int(arc4random_uniform(1000))) / 1000.0
        print("random \(random)")
        
        var enableWidget:Bool = random > 0.5
        enableWidget = true
        if (enableWidget){
            print ("enableWidget")
            return true
        }else {
            print ("disableWidget")
            return false
        }
        
    }
}


struct EmptyWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        WidgetBundleBuilder.buildBlock()
    }
}

struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
//        WidgetExtension()
        WidgetExtensionControl()
    }
}
