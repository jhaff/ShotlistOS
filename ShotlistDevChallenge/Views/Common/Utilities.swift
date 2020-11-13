//
//  Utilities.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/13/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import Foundation
import SwiftUI

struct GeometryGetter: View {
  @Binding var rect: CGRect
  
  var body: some View {
    GeometryReader { geometry in
      AnyView(Color.clear)
        .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
    }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
      self.rect = value
    }
  }
}

// for tracking any rectangle passed in
struct RectanglePreferenceKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}

class ViewFrame: ObservableObject {
  var startingRect: CGRect?
  
  @Published var frame: CGRect {
    willSet {
      if startingRect == nil {
        startingRect = newValue
      }
    }
  }
  
  init() {
    self.frame = .zero
  }
}
