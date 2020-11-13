//
//  ShotlistOptions.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct Options: View {
  private func showPhotoGuide() {}
  private func showQuickShot() {}

  var body: some View {
    HStack(spacing: 16) {
      ShotlistOptionsPill("Photo Guide", height: 28) {
        self.showPhotoGuide()
      }

      ShotlistOptionsPill("Quick View", height: 28) {
        self.showQuickShot()
      }

      Spacer()
    }.frame(height: 64)
  }
}

struct ShotlistOptionsPill: View {
  var label: String
  var background: Color
  var foreground: Color
  var height: CGFloat
  var action: () -> Void

  init(_ label: String,
       background: Color = foundationPrimaryA,
       foreground: Color = foundationPrimaryB,
       height: CGFloat = 24.0,
       action: @escaping () -> Void) {
    self.label = label
    self.foreground = foreground
    self.background = background
    self.height =  height
    self.action = action
  }

  var body: some View {
    Button(action: action) {
      Text(label)
        .font(.custom("Avenir-Heavy", size: 12))
        .foregroundColor(foreground)
        .padding(.horizontal, 16)
        .fixedSize(horizontal: true, vertical: false)
        .frame(height: height)
        .background(Capsule().fill(background))
    }
  }
}
