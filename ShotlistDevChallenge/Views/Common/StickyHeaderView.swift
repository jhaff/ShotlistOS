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
  
//  var body: some View {
//    HStack(spacing: 10) {
//      ShotlistHeaderButton(icon: "back-icon")
//
//      Text(titleText).onAppear {
//        self.onClick = self.doMagic
//      }.frame(width: 200, height: 100, alignment: .center)
//
////      Spacer()
//
//      Button(action: {
//        print("rendering...")
//      }) {
//        Image("export-icon")
//          .renderingMode(.template)
//          .resizable()
//          .aspectRatio(1.0, contentMode: .fit)
//          .frame(width: 24, height: 24)
//          .foregroundColor(foundationPrimaryB)
//      }
//    }
//    .frame(height: 44)
//    .padding(.top, 52)
//    .padding(.horizontal, 18)
//    .zIndex(40)
//  }
  
  var body: some View {
      HStack{
          Image(uiImage: #imageLiteral(resourceName: "shotlist-hero"))
              .resizable()
              .clipShape(Circle())
              .frame(width: 50, height: 50)
          Spacer()
          Text("Sample Shotlist")
              .bold()
          Spacer()
      }
      .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
      .padding(.horizontal)
      .padding(.bottom)
      .background(BlurBG())
  }
  
  // MARK: Blur background custom view
  struct BlurBG: UIViewRepresentable {
      func makeUIView(context: Context) -> UIVisualEffectView {
          
          // for dark mode adoption
          let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
          
          return view
          
      }
      
      func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
          
      }
  }
  
  private func doMagic() {
    print("We love closures")
    titleText = "But in a platonic way"
  }
  
  struct ShotlistHeaderButton: View {
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
          .foregroundColor(foundationPrimaryB)
      }.frame(width: 32, height: 32)
    }
  }
}
