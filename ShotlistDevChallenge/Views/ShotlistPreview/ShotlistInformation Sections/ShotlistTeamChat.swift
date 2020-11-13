//
//  ShotlistTeamChat.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct ShotlistTeamChat: View {
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        Text("Team + Chat")
          .font(.custom("Avenir-Medium", size: 18))
          .foregroundColor(contentPrimary)
        
        Spacer()
        
        Button(action: {
          print("invite new members")
        }) {
          Text("Invite Members")
            .font(.custom("Avenir-Roman", size: 16))
            .foregroundColor(contentSecondary)
        }
      }.frame(height: 44).padding(.bottom, 8)
      
      HStack(spacing: 16) {
        ShotlistTeamCard()
        ShotlistTeamCard()
      }
      .frame(height: 48)
      .padding(.bottom, 8)
      
      HStack(spacing: 16) {
        ShotlistTeamCard()
        ShotlistTeamCard()
      }
      .frame(height: 48)
      .padding(.bottom, 16)
      
      ShotlistChat()
      
    }.frame(height: 375)
  }
}

struct ShotlistChat: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .stroke(borderGray, lineWidth: 1)
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(backgroundSecondary)
    }.frame(height: 187)
  }
}


private struct ShotlistTeamCard: View {
  var body: some View {
    ZStack {
      // Background
      RoundedRectangle(cornerRadius: 16)
        .stroke(borderGray, lineWidth: 1)
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(backgroundSecondary)
      
      // Foreground
      HStack(spacing:8) {
        // Image
        ZStack {
          Circle()
          .frame(width: 32, height: 32)
          .foregroundColor(backgroundTertiary)
          Image(systemName: "person.fill")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(1.0, contentMode: .fit)
            .frame(width: 18)
            .foregroundColor(foundationPrimaryA)
        }.padding([.leading, .vertical], 8)
        
        VStack(alignment: .leading, spacing:0) {
          Text("Label")
            .font(.custom("Avenir-Heavy", size: 12))
            .foregroundColor(contentPrimary)
          Text("Label 2")
          .font(.custom("Avenir-Roman", size: 10))
          .foregroundColor(contentTertiary)
        }
        
        Spacer()
      }
    }
  }
}
