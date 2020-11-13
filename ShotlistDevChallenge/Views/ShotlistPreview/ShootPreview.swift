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
  let gradientColors: [Color] = [
    Color(red: 0.01, green: 0.01, blue: 0.01, opacity: 0.5),
    Color(red: 1, green: 1, blue: 1, opacity: 1)
  ]
  
  @ObservedObject var headerContent = ViewFrame() // potential code smell
  
  @State private var description: String = Shoot.sample.description
  @State private var headerImageRect: CGRect = .zero
  @State private var titleRect: CGRect = .zero
  
  @State var onClick: OnClickHandler = { }
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var showStickyHeader = false
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      ZStack {
        if self.showStickyHeader {
          StickyHeaderView(onClick: $onClick)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
            .padding(.horizontal)
            .padding(.bottom)
            .position(
              x: UIScreen.main.bounds.width / 2.0 ?? 0.0
            )
        }
        
          GeometryReader { geometry in
            ZStack {
              Image("shotlist-hero")
                .resizable()
                .scaledToFill()
//                .blur(radius: self.getBlurRadiusForImage(geometry)) // increasing blur while scrolling
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
            .offset(y: getOffsetForHeaderImage(geometry))
            .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
            
          }.frame(height: 390)
      }.background(GeometryGetter(rect: $headerContent.frame))
      VStack {
      ShotlistHeader(shoot: shoot, onClick: $onClick).zIndex(40)
      ShotlistPreview(onClick: $onClick).zIndex(50)
      }.offset(x: 0, y: -120) // how far up we want

    }.frame(maxWidth: .infinity, maxHeight: .infinity)
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
  private let imageHeight: CGFloat = 200 // 1
  private let collapsedImageHeight: CGFloat = 44
  
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let sizeOffScreen = imageHeight - collapsedImageHeight // 3
    
    if offset > 0 {
      print(offset)
      return -offset // case where image zooms in response to negative scrolling
    }
    
    print(offset)

    return 0
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
