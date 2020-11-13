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
      ZStack {
        ZStack {
          Image("shotlist-hero")
            .resizable()
            .scaledToFill()
            .blur(radius: self.getBlurRadiusForImage(geometry)) // increasing blur while scrolling
          .clipped()
            .onReceive(self.time) { (_) in // potential code smell, this is a
              let y = geometry.frame(in: .global).minY
              if -y > (UIScreen.main.bounds.height / 2.2) - 50 {
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
        .offset(x: UIScreen.main.bounds.width / 2 , y: getOffsetForHeaderImage(geometry))
      }
      .position(y: 0) //ensure header image overlaps safe area top
      .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
    }.frame(height: 390)
    ZStack {  
      VStack(spacing: 0) {
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
        }
        .padding(.horizontal, 16)
      }.zIndex(100)
    }
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
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    if offset > 0 {
      return imageHeight + offset
    }

    return imageHeight
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
