//
//  DebuggingLogger.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct DebuggingLogger {
    
    static func printData(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        if Constants.AppConfig.DEBUG_MODE {
            print(items, separator: separator, terminator: terminator)
        }
    }
}
