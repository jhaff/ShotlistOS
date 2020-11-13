//
//  StickyHeaderView.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/12/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import Foundation
import SwiftUI

struct StickyHeaderView: View {
  @Binding var onClick: OnClickHandler
  @State var titleText = "We love closures"
  
  private func goBack() {}
  
  var body: some View {
    ZStack {
      HStack {
        VStack(spacing: 0) {
          // Nav
          HStack(spacing: 10) {
            ShotlistStickyHeaderButton(icon: "back-icon")
            Spacer()
            Text("Sample Shotlist").bold()
            Spacer()
            ShotlistStickyHeaderButton(icon: "export-icon")
          }
        }
      }
    }
    .frame(height: 44)
    .padding(.top, 88)
    .padding(.horizontal, 18)
    .zIndex(40)
    .background(BlurBG())
    .frame(width:  UIScreen.main.bounds.width)
  }
  
  // MARK: Blur background custom view
  struct BlurBG: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
      // for dark mode adoption
      let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
      
      return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
      // conforming to UIViewRepresentable's protocols
    }
  }
  
  struct ShotlistStickyHeaderButton: View {
    var icon: String
    func action() {
      print("AHH")
    }
    
    var body: some View {
      Button(action: action) {
        Image(icon)
          .renderingMode(.template)
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: 24, height: 24)
          .foregroundColor(.black)
      }.frame(width: 32, height: 32)
    }
  }
}
