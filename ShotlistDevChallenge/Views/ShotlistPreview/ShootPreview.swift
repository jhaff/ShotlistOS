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
  @State private var description: String = Shoot.sample.description
  @State private var headerImageRect: CGRect = .zero
  @State private var titleRect: CGRect = .zero
  
  @State var onClick: OnClickHandler = { }
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var showStickyHeader = false
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        GeometryReader { geometry in
          ZStack {
            Image("shotlist-hero")
              .resizable()
              .scaledToFill()
              .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
              .clipped()
              .offset(x: UIScreen.main.bounds.width / 2 , y: getOffsetForHeaderImage(geometry))
              .blur(radius: self.getBlurRadiusForImage(geometry))
                    
                    StickyHeaderView(onClick: $onClick).opacity(0.7)
                      .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                      .frame(height: geometry.frame(in: .global).minY > 0 ?
                              UIScreen.main.bounds.height / 2.2 + geometry.frame(in: .global).minY  :
                              UIScreen.main.bounds.height / 2.2)
                      .onReceive(self.time) { (_) in // code smell, we are doing much more processing than needed
                        // For tracking the image is scrolled out or not
                        // print(g.frame(in: .global).minY)
                        
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
              }.position(y: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        }.frame(height: UIScreen.main.bounds.height / 2.2, alignment: .center)
        VStack {
          ShotlistHeader(shoot: shoot, onClick: $onClick).zIndex(0)
          ShotlistPreview(onClick: $onClick).zIndex(50)
        }
      }.padding(.vertical, -100)
      
      if self.showStickyHeader {
        StickyHeaderView(onClick: $onClick).position(x: UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0, y: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background(foundationPrimaryB)
    .edgesIgnoringSafeArea(.all)
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
    private let collapsedImageHeight: CGFloat = 50
    
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = getScrollOffset(geometry)
 
      return -offset + imageHeight / 2.2 // case where image zooms in response to negative scrolling
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
