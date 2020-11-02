//
//  ShotlistLocations.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct ShotlistLocations: View {
  
  var locations: [Location] = [ Location.sample ]
  
  var body: some View {
    VStack(spacing: 0) {
      // Header
      HStack(spacing: 0) {
        Text("Location(s)")
          .font(.custom("Avenir-Medium", size: 18))
          .foregroundColor(contentPrimary)
        
        Spacer()
        
        Button(action: {
          //
        }) {
          Text("Add Location")
            .font(.custom("Avenir-Roman", size: 16))
            .foregroundColor(contentSecondary)
        }
      }.frame(height: 44)
      
      // Body
      ScrollView(.horizontal, showsIndicators: false) {
        ForEach(locations, id: \.id) { location in
          LocationCard(location)
        }
      }
      
    }.frame(height: 148).padding(.top, 35)
  }
}
