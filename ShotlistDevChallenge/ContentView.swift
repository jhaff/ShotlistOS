//
//  ContentView.swift
//  ShotlistDevChallenge
//
//  Created by Daniel Ashy on 11/2/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var onClick: OnClickHandler = { }

  var body: some View {
    ZStack {
      ParentView()
      
    }
    }
  }

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
