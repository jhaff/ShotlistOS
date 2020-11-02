//
//  ShotlistRequiredShots.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct ShotlistRequiredShots: View {
  var shots: [Shot] = [ Shot.sample ]
  
  private func action() {}

  
  var body: some View {
    VStack(spacing: 0) {
      // Header
      HStack(spacing: 0) {
        Text("Required Shots")
          .font(.custom("Avenir-Heavy", size: 20))
          .foregroundColor(contentPrimary)
        
        Spacer()
        
        Button(action: {
          //
        }) {
          Text("Add Shot")
            .font(.custom("Avenir-Roman", size: 14))
            .foregroundColor(contentSecondary)
        }
      }
      .frame(height: 44)
      .padding(.bottom, 8)
      
      // Body
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(shots, id: \.id) { shot in
            RequiredShotCard(shot: shot) {
              self.action()
            }
          }
        }
      }
    }.frame(height: 216)
  }
}

private struct RequiredShotCard: View {
  var shot: Shot
  let action: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Group {
        Image("sample-shot")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
        
      }.cornerRadius(16)
      
      VStack(alignment: .leading, spacing: 0) {
        Text(shot.title)
          .font(.custom("Avenir-Heavy", size: 14))
          .foregroundColor(contentPrimary)
        Text("Motion")
          .font(.custom("Avenir-Roman", size: 12))
          .foregroundColor(contentSecondary)
      }.frame(height: 40)
    }
    .onTapGesture(perform: action)
  }
}

