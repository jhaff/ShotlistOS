//
//  Colors.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/21/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

// Background
let backgroundPrimary = Color(r: 255, g: 255, b: 255)
let backgroundSecondary = Color(r: 246, g: 246, b: 246)
let backgroundTertiary = Color(r: 238, g: 238, b: 238)

// Content
let contentPrimary = Color(r: 31, g: 31, b: 31)
let contentSecondary = Color(r: 84, g: 84, b: 84)
let contentTertiary = Color(r: 175, g: 175, b: 175)

// Foundation
let foundationPrimaryA = Color(r: 31, g: 31, b: 31)
let foundationPrimaryB = Color(r: 255, g: 255, b: 255)
let foundationAccent = Color(r: 251, g: 131, b: 51)
let foundationNegative = Color(r: 255, g: 59, b: 48)
let foundationWarning = Color(r: 252, g: 221, b: 96)
let foundationPositive = Color(r: 56, g: 193, b: 113)

// Other
let borderGray = Color(r: 226, g: 226, b: 226)
let dividerGray = Color(r: 234, g: 234, b: 234)
let fontGray = Color(r: 138, g: 138, b: 143)
let iconGray = Color(r: 117, g: 117, b: 117)

// New shotlist header colors
let newSLBlue   = Color(r: 30, g: 72, b: 108)
let newSLGreen  = Color(r: 22, g: 77, b: 45)
let newSLOrange = Color(r: 200, g: 80, b: 0)
let newSLRed    = Color(r: 102, g: 23, b: 19)
let newSLGray   = Color(r: 84, g: 84, b: 84)
let newSLPurple = Color(r: 108, g: 30, b: 91)
let newSLGold   = Color(r: 108, g: 86, b: 30)

extension Color {
  init<T: BinaryInteger>(r: T, g: T, b: T, a: T = 255) {
      self.init(red: .init(r)/255, green: .init(g)/255, blue: .init(b)/255)
  }
  init<T: BinaryFloatingPoint>(r: T, g: T, b: T, a: T = 1.0) {
      self.init(red: .init(r), green: .init(g), blue: .init(b))
  }
}
