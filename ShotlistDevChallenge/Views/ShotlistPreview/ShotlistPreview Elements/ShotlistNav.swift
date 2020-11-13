//
//  ShotlistNav.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/13/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import Foundation
import SwiftUI

struct ShotlistNav: View {
  var body: some View {
    HStack(spacing: 10) {
      Button(action: {}) {
        Image("back-icon")
          .renderingMode(.template)
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: 24, height: 24)
          .foregroundColor(foundationPrimaryB)
      }

      Spacer()

      Button(action: {

      }) {
        Image("export-icon")
          .renderingMode(.template)
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: 24, height: 24)
          .foregroundColor(foundationPrimaryB)
      }
    }
    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 44 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 88)
    .padding(.horizontal)
    .padding(.bottom)
    .position(x: UIScreen.main.bounds.width / 2.0 )
  }
}
