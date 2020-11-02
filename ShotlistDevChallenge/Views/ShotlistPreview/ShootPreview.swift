//
//  ShootPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI


struct ShootPreview: View {
  var shoot: Shoot = Shoot.sample
  @State private var description: String = Shoot.sample.description
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      ShotlistHeader(shoot: shoot).zIndex(40)
      Group {
        ShotlistStatusBar()
          .padding(.horizontal, 38)
        BackgroundInfo(description: $description)
        Options()
        ShotlistRequiredShots()
        ShotlistLocations()
        TasksPreview()
        ShotlistTeamChat()
      }.padding(.horizontal, 16).zIndex(10)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(foundationPrimaryB)
    .edgesIgnoringSafeArea(.all)
  }
}

struct ShotlistStatusBar: View {
  private var states: [String] = [
    "Concept", "Scheduled", "Editing", "Complete"
  ]
  
  var body: some View {
    VStack(spacing: 0) {
      StateBar(states: self.states,
               current: "Scheduled")
    }.frame(height: 80)
  }
}
