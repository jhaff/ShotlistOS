//
//  ShotlistBackgroundInfo.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct BackgroundInfo: View {
  @Binding var description: String
  
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Text("Background")
          .font(.custom("Avenir-Heavy", size: 20))
          .foregroundColor(contentPrimary)
        Spacer()
      }
      
      // MARK: TODO edit this description box
      Text(description)
        .font(.custom("Avenir-Roman", size: 12))
        .foregroundColor(contentPrimary)
    }
  }
}
