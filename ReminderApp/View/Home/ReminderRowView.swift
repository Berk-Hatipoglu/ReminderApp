//
//  ReminderRowView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 11.07.2024.
//

import SwiftUI

struct ReminderRowView: View {
    @Binding var reminder: Reminder

    var onUpdate: (Reminder) -> Void
    var onDelete: (Reminder) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reminder.title) 
                    .font(.headline)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled(true)
                Text(reminder.description) 
                    .font(.subheadline)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled(true)
                    
                Text("Date: \(reminder.date, formatter: dateFormatter)") .font(.caption)
                Text("Time: \(reminder.time, formatter: timeFormatter)") .font(.caption)
            }
            Spacer()
            Image(systemName: reminder.isCompleted == 1 ? "checkmark.circle.fill" : (reminder.isCompleted == -1 ? "xmark.circle.fill" : "circle"))
                .foregroundColor(reminder.isCompleted == 1 ? .green : (reminder.isCompleted == -1 ? .red : .gray))
        }
        .padding()
        .background(reminderBackgroundColor(reminder.isCompleted))
        .cornerRadius(10)
        .onChange(of: reminder.isCompleted){
            onUpdate(reminder)
        }
        .swipeActions {
            Button(role: .destructive) {
                onDelete(reminder)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    private func reminderBackgroundColor(_ isCompleted: Int) -> Color {
        switch isCompleted {
        case 1:
            return .green.opacity(0.2)
        case -1:
            return .red.opacity(0.2)
        default:
            return .gray.opacity(0.4)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()
