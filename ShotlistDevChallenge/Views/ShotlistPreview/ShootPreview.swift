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
    ZStack(alignment: .top, content: {
    ScrollView(showsIndicators: false) {
      GeometryReader { g in
        //      print("rendering...")
        StickyHeaderView(onClick: $onClick).opacity(0.7)
          .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
          .frame(height: g.frame(in: .global).minY > 0 ?
              UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  :
              UIScreen.main.bounds.height / 2.2)
          .onReceive(self.time) { (_) in // code smell, we are doing much more processing than needed
            // For tracking the image is scrolled out or not
            // print(g.frame(in: .global).minY)
            
            let y = g.frame(in: .global).minY
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
      }.frame(height: UIScreen.main.bounds.height / 2.2)
      
      VStack(spacing: -44) {
        // shotlist preview generic instantiation
        VStack {
          ShotlistHeader(shoot: shoot, onClick: $onClick).zIndex(0)
          ShotlistPreview(onClick: $onClick).zIndex(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(foundationPrimaryB)
        .edgesIgnoringSafeArea(.all)
      }
    }
      if self.showStickyHeader {
        StickyHeaderView(onClick: $onClick)
      }
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(foundationPrimaryB)
    .edgesIgnoringSafeArea(.all)
  }
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
