//
//  TaskPreview.swift
//  Shotlist
//
//  Created by Daniel Ashy on 9/29/20.
//  Copyright © 2020 Daniel Ashy. All rights reserved.
//

import SwiftUI

struct TasksPreview: View {
  var tasks: [Task] = [ Task.sample ]
  let title: String

  init(title: String = "Tasks") {
    self.title = title
  }

  private func addTask() {}
  private func showOverview() {}

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text(title)
          .font(.custom("Avenir-Medium", size: 18))
          .foregroundColor(contentPrimary)
        Spacer()
        Button(action: addTask) {
          Image("add-icon")
            .resizable()
            .renderingMode(.original)
            .frame(width: 24, height: 24)
            .padding(.trailing, 16)
        }
      }
      .frame(height: 44)

      VStack(spacing: 20) {
        ForEach(tasks, id: \.id) { task in
          TaskPreviewCard(task) {
            self.showOverview()
          }
        }

        AddButton {
          self.addTask()
        }
      }
    }
  }
}

private struct TaskPreviewCard: View {
  let task: Task
  let icons: [String] = [ "task-calendar", "task-notes",
                          "task-subtask", "task-shotlist" ]
  let action: () -> Void

  init(_ task: Task, action: @escaping () -> Void) {
    self.task = task
    self.action = action
  }

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(backgroundPrimary)
      RoundedRectangle(cornerRadius: 10)
        .stroke(borderGray, lineWidth: 1)
      HStack(spacing: 0) {
        Image("circle-unselected")
          .resizable()
          .renderingMode(.template)
          .aspectRatio(contentMode: .fit)
          .frame(width: 24, height: 24)
          .foregroundColor(foundationAccent)
          .padding(.horizontal, 14)

        Text(task.title)
          .font(.custom("Avenir-Roman", size: 16))
          .foregroundColor(contentPrimary)

        Spacer()

        HStack(spacing: 4) {
          ForEach(icons, id: \.self) { icon in
            Image(icon)
              .renderingMode(.template)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 16)
              .foregroundColor(iconGray)
          }
        }
        .frame(maxHeight: 16)
        .padding(.trailing, 24)
      }
    }
    .frame(height: 56)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .shadow(color: borderGray, radius: 2, x: 2, y: 2)
    ).onTapGesture(perform: action)
  }
}

private struct AddButton: View {
  var action: () -> Void

  var body: some View {
    Button(action: action) {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(backgroundPrimary)
        RoundedRectangle(cornerRadius: 10)
          .stroke(borderGray, lineWidth: 1.0)
        Image(systemName: "plus.circle")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(contentSecondary)
          .frame(width: 20, height: 20)
      }
      .padding(1)
      .frame(height: 56)
      .background(
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(borderGray)
          .shadow(color: borderGray, radius: 2, x: 2, y: 2)
      )
    }
  }
}
