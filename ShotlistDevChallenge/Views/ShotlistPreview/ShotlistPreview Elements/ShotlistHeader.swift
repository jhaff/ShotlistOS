//
//  ShotlistHeader.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//  Parallax scrolling achieved with:
//  https://medium.com/swlh/swiftui-create-a-stretchable-header-with-parallax-scrolling-4a98faeeb262

import SwiftUI

struct ShotlistHeader: View {
  var shoot: Shoot

  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        // title header
        HStack(spacing: 0) {
          VStack(alignment: .leading, spacing: 8) {
            Text("10 October 2020")
              .font(.custom("Avenir-Roman", size: 14))
              .foregroundColor(foundationPrimaryB)
            Text(shoot.title)
              .font(.custom("Avenir-Medium", size: 32))
              .foregroundColor(foundationPrimaryB)
              .lineLimit(1)
              .frame(maxWidth: 300, alignment: .leading)

            // button group
            HStack(spacing: 0) {
              Text("Los Angeles, CA")
                .font(.custom("Avenir-Roman", size: 16))
                .foregroundColor(contentPrimary)

              Spacer()

              ShotlistHeaderButton(icon: "chat-tab") {
                // config button action here
              }.padding(.trailing, 8)

              ShotlistHeaderButton(icon: "download-icon") {
                // config button action here
              }
            }
          }
        }
        .padding(.horizontal, 16)
      }.zIndex(100)
    }
  }
}

struct ShotlistHeaderButton: View {
  var icon: String
  var action: () -> Void

  var body: some View {
    Button(action: action) {
      Image(icon)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .foregroundColor(foundationPrimaryA)
        .frame(width: 16, height: 16)
        .background(
          ZStack {
            Circle()
              .stroke(iconGray, lineWidth: 1)
              .frame(width: 32, height: 32)
            Circle()
              .frame(width: 32, height: 32)
              .foregroundColor(foundationPrimaryB)
          }
        )
    }.frame(width: 32, height: 32)
  }
}
