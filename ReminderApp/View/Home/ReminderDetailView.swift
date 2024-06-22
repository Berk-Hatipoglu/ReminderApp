//
//  ReminderDetailView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 11.07.2024.
//

import SwiftUI

struct ReminderDetailView: View {
    @Binding var showModal: Bool
    @Binding var reminder: Reminder
    var onSave: (Reminder) -> Void

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date and Time")) {
                    DatePicker("Date", selection: $reminder.date, displayedComponents: .date)
                    DatePicker("Time", selection: $reminder.time, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Details")) {
                    customTextField(title: "Title", text: $reminder.title)
                    customTextField(title: "Description", text: $reminder.description)
                }

                Section(header: Text("Status")) {
                    Picker("Status", selection: $reminder.isCompleted) {
                        Text("Not Completed").tag(0)
                        Text("Overdue").tag(-1)
                        Text("Completed").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

            }
            .navigationBarTitle("Reminder", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    showModal = false
                },
                trailing: Button("Save") {
                    onSave(reminder)
                    showModal = false
                }
            )
        }
    }
}
