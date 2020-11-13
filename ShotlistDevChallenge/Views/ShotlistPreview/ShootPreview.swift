//
//  ShootPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

typealias OnClickHandler = (() -> Void)

struct ShootPreview: View {
  var shoot: Shoot = Shoot.sample
  
  @ObservedObject var headerContent = ViewFrame() // potential code smell
  
  @State private var description: String = Shoot.sample.description
  @State private var headerImageRect: CGRect = .zero
  @State private var titleRect: CGRect = .zero
  
  @State var onClick: OnClickHandler = { }
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var showStickyHeader = false
  
  var body: some View {
    ZStack {
      ScrollView(showsIndicators: false) {
        ParallaxView(onClick: $onClick, showStickyHeader: $showStickyHeader)
        VStack {
          ShotlistHeader(shoot: shoot, onClick: $onClick).zIndex(40)
          ShotlistPreview(onClick: $onClick).zIndex(50)
        }.offset(x: 0, y: -120) // how far up we want
        
      }.background(GeometryGetter(rect: $headerContent.frame))
      
      if self.showStickyHeader {
        StickyHeaderView(onClick: $onClick)
          .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
          .padding(.horizontal)
          .padding(.bottom)
          .position(
            x: UIScreen.main.bounds.width / 2.0 ?? 0.0
          )
      } else {
        HStack(spacing: 10) {
          Button(action: onClick) {
            Image("back-icon")
              .renderingMode(.template)
              .resizable()
              .aspectRatio(1.0, contentMode: .fit)
              .frame(width: 24, height: 24)
              .foregroundColor(foundationPrimaryB)
          }
          
          Spacer()
          
          Button(action: {
            
          }) {
            Image("export-icon")
              .renderingMode(.template)
              .resizable()
              .aspectRatio(1.0, contentMode: .fit)
              .frame(width: 24, height: 24)
              .foregroundColor(foundationPrimaryB)
          }
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 44 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 88)
        .padding(.horizontal)
        .padding(.bottom)
        .position(
          x: UIScreen.main.bounds.width / 2.0 ?? 0.0
        )
        
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(foundationPrimaryB)
    .edgesIgnoringSafeArea(.all)
    
  }

  private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
    
    let offset = geometry.frame(in: .global).maxY
    
    let height = geometry.size.height
    let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
    return blur * 3 // Values will range from 0 - 6
  }
  
  class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
      willSet {
        if startingRect == nil {
          startingRect = newValue
        }
      }
    }
    
    init() {
      self.frame = .zero
    }
  }
  
  struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
      GeometryReader { geometry in
        AnyView(Color.clear)
          .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
      }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
        self.rect = value
      }
    }
  }
  
  // for tracking any rectangle passed in
  struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
      value = nextValue()
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
}
