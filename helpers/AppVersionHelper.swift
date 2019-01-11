//
//  AppVersionHelper.swift
//
//  Created by Mikhail Muravev on 11/01/2019.
//  Copyright © 2019 M-Technology. All rights reserved.
//

import UIKit

func appName() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
}

func appVersion() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}

func appBuild() -> String {
    return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
}

func versionBuild() -> String {
    let version = appVersion(), build = appBuild()
    return version == build ? "VERSION \(version)" : "VERSION \(version) (build \(build))"
}

