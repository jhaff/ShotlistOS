//
//  TextView.swift
//  ShotlistDevChallenge
//
//  Created by Jacob Haff on 11/10/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//  For creating editable text views in SwiftUI in iOS13

import Foundation
import SwiftUI

// an editable text view derived from UIKit but usable with SwiftUI
struct TextView: UIViewRepresentable {
  @Binding var text: String
  @Binding var shoot: Shoot
  @Binding var textStyle: UIFont.TextStyle
  @Binding var isEditing: Bool

  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()

    textView.text = text
    textView.delegate = context.coordinator
    textView.font = UIFont.preferredFont(forTextStyle: textStyle)
    textView.autocapitalizationType = .sentences
    textView.isSelectable = true

    textView.isUserInteractionEnabled = isEditing

    return textView
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
    //TODO: Test that this also summons keyboard on physical iphone
    uiView.isUserInteractionEnabled = isEditing
    uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
  }

  func makeCoordinator() -> Coordinator {
    Coordinator($text)
  }

  class Coordinator: NSObject, UITextViewDelegate {
    var text: Binding<String>

    init(_ text: Binding<String>) {
      self.text = text
    }

    func textViewDidChange(_ textView: UITextView) {
      let fixedWidth = textView.frame.size.width
      self.text.wrappedValue = textView.text

      textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
      let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
      var newFrame = textView.frame
      newFrame.size = CGSize(width: 100, height: 100)
      textView.frame = newFrame
    }
  }
}
