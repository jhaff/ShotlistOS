//
//  ShotlistHeader.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct ShotlistHeader: View {
  var shoot: Shoot
  let gradientColors: [Color] = [
    Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 0.1),
    Color(red: 1, green: 1, blue: 1, opacity: 1)
  ]
  
  private func goBack() {}
  
  var body: some View {
    ZStack {
      ZStack {
        Image("shotlist-hero")
          .renderingMode(.original)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 390)
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
      }
      .frame(height: 390)
      .clipped()
      
      VStack(spacing: 0) {
        // Nav
        HStack(spacing: 10) {
          Button(action: goBack) {
            Image("back-icon")
              .renderingMode(.template)
              .resizable()
              .aspectRatio(1.0, contentMode: .fit)
              .frame(width: 24, height: 24)
              .foregroundColor(foundationPrimaryB)
          }
          
          Spacer()
          
          Button(action: {
            //
          }) {
            Image("export-icon")
              .renderingMode(.template)
              .resizable()
              .aspectRatio(1.0, contentMode: .fit)
              .frame(width: 24, height: 24)
              .foregroundColor(foundationPrimaryB)
          }
        }
        .frame(height: 44)
        .padding(.top, 52)
        .padding(.horizontal, 18)
        .zIndex(40)
        
        Spacer()
        
        // title
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
                //
              }.padding(.trailing, 8)
              
              ShotlistHeaderButton(icon: "download-icon") {
                //
              }
            }
          }
          Spacer()
        }
        .padding(.horizontal, 16)
      }
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

