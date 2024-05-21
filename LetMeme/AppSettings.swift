//
//  AppSettings.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/5/21.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    public static let shared = AppSettings()
    @AppStorage("colorTimerInterval") var colorTimerInterval: Double = 8
    @AppStorage("colorfulViewOpacity") var colorfulViewOpacity: Double = 0.55
    @AppStorage("subRedditName") var subRedditName:String = ""
    @AppStorage("subRedditNameIsLocked") var subRedditNameIsLocked:Bool = false
}
