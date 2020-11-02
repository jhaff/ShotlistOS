//
//  LocationCard.swift
//  Shotlist
//
//  Created by Daniel Ashy on 10/20/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct LocationCard: View {
  var location: Location
  
  init(_ location: Location) {
    self.location = location
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .stroke(borderGray, lineWidth: 1)
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(backgroundSecondary)
      HStack(spacing:0) {
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .stroke(borderGray, lineWidth: 1)
          Image("map-preview")
            .resizable()
            .renderingMode(.original)
            .cornerRadius(10)
        }
        .frame(width: 32, height: 56)
        .padding(.horizontal, 8)
          
        VStack(alignment: .leading, spacing:0) {
          Text(location.title)
            .font(.custom("Avenir-Heavy", size: 14))
            .foregroundColor(contentPrimary)
          Text("Los Angeles, CA")
            .font(.custom("Avenir-Roman", size: 10))
            .foregroundColor(contentPrimary)
        }
      }
    }
    .frame(height: 64)
    .padding(.vertical, 8)
    .padding(.horizontal, 2)
    .overlay(
      Image("bookmark")
        .resizable()
        .renderingMode(.original)
        .frame(width: 10, height: 15)
        .offset(x: 50, y: -25)
    )
  }
}

