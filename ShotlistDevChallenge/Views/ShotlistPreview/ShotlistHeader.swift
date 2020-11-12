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
  
  @State private var titleRect: CGRect = .zero
  @Binding var onClick: OnClickHandler
  @State private var headerImageRect: CGRect = .zero
  
  private func goBack() {}
  
  // MARK: Main view for Shotlist Header
  var body: some View {
    // MARK: For background image zooming on negative scroll
    GeometryReader { geometry in
      Image("shotlist-hero")
        .resizable()
        .scaledToFill()
        .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
        .clipped()
        .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
        .blur(radius: self.getBlurRadiusForImage(geometry))
    }
    .frame(height: 300)
    
    // MARK: For background image zooming on negative scroll
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
      }
      Spacer()
    }
    .padding(.horizontal, 16)
    
  }
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    if offset > 0 {
      return imageHeight + offset
    }
    return imageHeight
  }
  
  
  private func shouldPresentStickyHeader() -> Bool {
    let currentYPos = titleRect.midY
    
    print("header should be presenting!!!! \(titleRect.midY)")
    
    if currentYPos < headerImageRect.maxY {
      return true
    }
    return false
  }
  
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
}
