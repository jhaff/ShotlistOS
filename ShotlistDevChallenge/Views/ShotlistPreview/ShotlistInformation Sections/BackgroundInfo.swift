//
//  ShotlistBackgroundInfo.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct BackgroundInfo: View {
  @Binding var shoot: Shoot
  @Binding var textStyle: UIFont.TextStyle
  @Binding var editTapped: EditTappedHandler

  @State var isEditing: Bool = false

  //navbar: 44px, YES put in buttons
  var body: some View {

    VStack(spacing: 8) {
      BackgroundInfoHeader(description: $shoot.description, editTapped: $editTapped, shoot: $shoot, isEditing: $isEditing)

      Spacer()
    }

    TextView(text: $shoot.description, shoot: $shoot, textStyle: $textStyle, isEditing: $isEditing)
      .frame(height: 100, alignment: .leading) // TODO: set height programmatically by textview content

  }
}

struct BackgroundInfoHeader: View {
  @Binding var description: String
  @Binding var editTapped: EditTappedHandler
  @Binding var shoot: Shoot

  @Binding var isEditing: Bool

  var body: some View {
    HStack {
      Text("Background")
        .font(.custom("Avenir-Heavy", size: 20))
        .foregroundColor(contentPrimary)
      Button(action: {
        print("Edit button was tapped")
        isEditing.toggle()
        //TODO: Find elegant way to change and persist change to shoot.description.
        //For now this is a moot point, as shoot is recreated from Shoot.sample every time the app is opened.
        shoot.description = description
      }) {
        if isEditing == true {
          Image(systemName: "pencil").colorInvert()
        } else {
          Image(systemName: "pencil")
        }
      }
      Spacer()
    }
  }
}
