//
//  ShotlistInformation.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/13/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import Foundation
import SwiftUI

struct ShotlistInformation: View {
  @Binding var shoot: Shoot
  @State private var description: String = Shoot.sample.description
  @State private var textStyle: UIFont.TextStyle = UIFont.TextStyle.body
  @State var isEditing: Bool = false
  @State var editTapped: EditTappedHandler = { }

  @Binding var onClick: OnClickHandler

  var body: some View {
    Group {
      ShotlistStatusBar()
        .padding(.horizontal, 38)
      BackgroundInfo(shoot: $shoot, textStyle: $textStyle, editTapped: $editTapped)
      Options()
      ShotlistRequiredShots()
      ShotlistLocations()
      TasksPreview()
      ShotlistTeamChat()
    }
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
