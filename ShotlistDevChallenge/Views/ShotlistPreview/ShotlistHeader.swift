//
//  ShotlistHeader.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//  Sticky header achieved with:
//  https://medium.com/swlh/swiftui-create-a-stretchable-header-with-parallax-scrolling-4a98faeeb262

import SwiftUI

struct ShotlistHeader: View {
  var shoot: Shoot
  let gradientColors: [Color] = [
    Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 0.1),
    Color(red: 1, green: 1, blue: 1, opacity: 1)
  ]
  
  private func goBack() {}
    
  // at 0 offset our blur will be 0
  // at 300 offset our blur will be 6
  private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {

    let offset = geometry.frame(in: .global).maxY

    let height = geometry.size.height
    let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
    return blur * 6 // Values will range from 0 - 6
  }
    
  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
          geometry.frame(in: .global).minY
  }
        
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
            
    // Image was pulled down
    if offset > 0 {
        return -offset
    }
    return 0
  }
    
  
  private let imageHeight: CGFloat = 300 // 1
  private let collapsedImageHeight: CGFloat = 75 // 2

  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    if offset > 0 {
      return imageHeight + offset
    }

    return imageHeight
  }

  var body: some View {
    ZStack {
        GeometryReader { geometry in
          Image("shotlist-hero")
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
            .clipped()
            .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
            .blur(radius: self.getBlurRadiusForImage(geometry))
        }.frame(height: 390)       
      .frame(height: 390)
        
      
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

