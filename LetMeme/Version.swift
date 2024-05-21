//
//  Version.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/5/21.
//

import Foundation

let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
