//
//  ShootPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

typealias OnClickHandler = (() -> Void)

struct ParentView: View {
  var shoot: Shoot = Shoot.sample
  let gradientColors: [Color] = [
    Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 0.5),
    Color(red: 1, green: 1, blue: 1, opacity: 1)
  ]
  
  @State private var description: String = Shoot.sample.description
  @State private var headerImageRect: CGRect = .zero
  @State private var titleRect: CGRect = .zero
  
  @State var onClick: OnClickHandler = { }
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var showStickyHeader = false
  
  var body: some View {
//    ZStack {
      ScrollView(showsIndicators: false) {
//        VStack {
          
          
          VStack {
            ShotlistHeader(shoot: shoot, onClick: $onClick).zIndex(0)
            ShotlistPreview(onClick: $onClick).zIndex(50)
          }.offset(x: 0, y: -120) // how far up we want the scroll view to start is this y value
//        }.padding(.vertical)
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(foundationPrimaryB)
      .edgesIgnoringSafeArea(.all)
      
      if self.showStickyHeader {
        StickyHeaderView(onClick: $onClick)
          .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
          .padding(.horizontal)
          .padding(.bottom)
          .position(
            x: UIScreen.main.bounds.width / 2.0 ?? 0.0)
      }
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .background(foundationPrimaryB)
//    .edgesIgnoringSafeArea(.all)
  }
  
  
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    if offset > 0 {
      return imageHeight + offset
    }
    return imageHeight
  }
  private let imageHeight: CGFloat = 390 // 1
  private let collapsedImageHeight: CGFloat = 44
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let scrollOffset = getScrollOffset(geometry)
    let sizeOffScreen = imageHeight// 3
    
    // subtradct safeAreaInsets.top so that image will overlap safe area
    
    let offset = getScrollOffset(geometry)
    
    //    print(offset)
    
    // for the negative scroll
    if offset > 0 {
      print("-offset")
      print(-offset + (imageHeight / 2.2))
      
      return  200 - offset// case where image zooms in response to negative scrolling
    }
    
    
    
    if offset < -sizeOffScreen { // case to create the 44px sticky header after scrolling far enough
      // Since we want 44 px fixed on the screen we get our offset of -256 or anything less than. Take the abs value
      let imageOffset = abs(min(-sizeOffScreen, offset))
      
      // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
      print("cool")
      
      return imageOffset - sizeOffScreen
    }

    return imageHeight / 2
  }
  
  private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
    
    let offset = geometry.frame(in: .global).maxY
    
    let height = geometry.size.height
    let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
    return blur * 3 // Values will range from 0 - 6
  }
  
  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
    geometry.frame(in: .global).minY
  }
  
  
  
  struct ShotlistPreview: View {
    var shoot: Shoot = Shoot.sample
    @State private var description: String = Shoot.sample.description
    @Binding var onClick: OnClickHandler
    
    var body: some View {
      Group {
        ShotlistStatusBar()
          .padding(.horizontal, 38)
        BackgroundInfo(description: $description)
        Options()
        ShotlistRequiredShots()
        ShotlistLocations()
        TasksPreview()
        ShotlistTeamChat()
      }.padding(.horizontal, 16).zIndex(10)
    }
  }
  
  struct ShotlistStatusBar: View {
    private var states: [String] = [
      "Concept", "Scheduled", "Editing", "Complete"
    ]
    
    var body: some View {
      VStack(spacing: 0) {
        StateBar(states: self.states,
                 current: "Scheduled")
      }.frame(height: 80)
    }
  }
}
