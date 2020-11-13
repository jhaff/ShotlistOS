//
//  ShootPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

typealias OnClickHandler = (() -> Void)
typealias EditTappedHandler = (() -> Void)

struct ShotlistPreview: View {
  @ObservedObject var headerContent = ViewFrame() // potential code smell

  @State var shoot: Shoot = Shoot.sample
  @State var onClick: OnClickHandler = { }
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var showStickyHeader = false

  var body: some View {
    ZStack {
      ScrollView(showsIndicators: false) {
        // responsive background image
        ParallaxView(showStickyHeader: $showStickyHeader)

        VStack {
          ShotlistHeader(shoot: shoot).zIndex(40)
          ShotlistInformation(shoot: $shoot, onClick: $onClick).zIndex(50).padding(.horizontal, 16).zIndex(10)
        }
        .offset(y: -120) // how far up we want the scroll to default
      }.background(GeometryGetter(rect: $headerContent.frame))

      if self.showStickyHeader {
        StickyHeaderView(onClick: $onClick)
          .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
          .padding(.horizontal)
          .padding(.bottom)
          .position(
            x: UIScreen.main.bounds.width / 2.0
          )
      } else {
        // top non-sticky nav
        ShotlistNav()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(foundationPrimaryB)
    .edgesIgnoringSafeArea(.all)
  }
}
