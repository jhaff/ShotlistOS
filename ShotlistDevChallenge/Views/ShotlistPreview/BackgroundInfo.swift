//
//  ShotlistBackgroundInfo.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/28/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct BackgroundInfo: View {
  @Binding var description: String
  
    // Var Editing: some Button
    
    // fanciness: dissmiss keyboard upon scrolling and save description and change state of button
    
    // Auto scroll to Background on top
    
    // stretch goal: rounded background light grey rectangle on editing state

    
    // https://medium.com/swlh/swiftui-create-a-stretchable-header-with-parallax-scrolling-4a98faeeb262
    
    
    
    // Sticky header: include back and share buttons in header/navbar. Push image
    // to top and animate title moving to header position.
    
    // stretch goal: reverse scroll makes bg image zoom
    
    
    // use geometry reader for potential autoscroller
    // keyboard guard at bottom of background info. Pushes view up to the top of the keyboard
    
    
    //navbar: 44px, YES put in buttons
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Text("Background")
          .font(.custom("Avenir-Heavy", size: 20))
          .foregroundColor(contentPrimary)
        Button(action: {
            print("Edit button was tapped")
        }) {
            Image(systemName: "pencil")
        }
        Spacer()
      }
      
      // MARK: TODO edit this description box
        
        // if editing == true {
        // TextEditor(text: $description)
//      .font(.custom("Avenir-Roman", size: 14))
//      .foregroundColor(contentPrimary)
        //else
        
      Text(description)
        .font(.custom("Avenir-Roman", size: 12))
        .foregroundColor(contentPrimary)
    }
  }
}
//
//struct BackgroundInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundInfo(description: "Test")
//    }
//}

//struct BackgroundInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
