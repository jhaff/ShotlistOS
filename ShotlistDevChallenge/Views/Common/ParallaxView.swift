//
//  ParallaxView.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/12/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import Foundation

import SwiftUI

struct ParallaxView: View {
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  
  @Binding var showStickyHeader: Bool
  
  let gradientColors: [Color] = [
    Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 0.5),
    Color(red: 1, green: 1, blue: 1, opacity: 1)
  ]
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Image("shotlist-hero")
          .resizable()
          .scaledToFill()
          .blur(radius: self.getBlurRadiusForImage(geometry)) // increasing blur while scrolling
          .clipped()
          .onReceive(self.time) { (_) in // potential code smell, this is a lot of processing
            let y = geometry.frame(in: .global).minY
            if -y > (UIScreen.main.bounds.height / 2.2) - 44 {
              withAnimation{
                self.showStickyHeader = true
              }
            } else {
              withAnimation{
                self.showStickyHeader = false
              }
            }
          }
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
      }
      .offset(y: getOffsetForHeaderImage(geometry))
      .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
    }.frame(height: 390)
  }
  
  private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
    
    let offset = geometry.frame(in: .global).maxY
    
    let height = geometry.size.height
    let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
    return blur * 3 // Values will range from 0 - 6
  }
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    if offset > 0 {
      return imageHeight + offset
    }
    return imageHeight
  }
  
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    
    if offset > 0 {
      return -offset // case where image zooms in response to negative scrolling
    }
    return 0
  }
  
  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
    geometry.frame(in: .global).minY
  }
}
