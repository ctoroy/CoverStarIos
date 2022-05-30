//
//  CoverStar.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/20.
//

import UIKit

let httpTool : NetworkHelper = NetworkHelper.manager
let popupManager : PopupManager = PopupManager.manager
//MARK: - Dispatch
let dispatchMain = DispatchQueue.main
let dispatchGlobal = DispatchQueue.global()
let appData = UserDefaults.standard
