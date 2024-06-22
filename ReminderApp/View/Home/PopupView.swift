//
//  PopupView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 9.07.2024.
//

import SwiftUI
import Firebase

struct PopupView: View {
    @StateObject private var homeViewModel = HomeViewModel()

    @Binding var showModal: Bool
    @Binding var date: Date
    @Binding var time: Date
    @Binding var title: String
    @Binding var description: String

    var userId: String
    let db = Firestore.firestore()

    var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Date and Time")) {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    }
                    
                    Section(header: Text("Details")) {
                        customTextField(title: "Title", text: $title)
                        customTextField(title: "Description", text: $description)
                    }
                }
                .navigationBarTitle("New Reminder", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        showModal.toggle()
                    }) {
                        Text("Cancel")
                    },
                    trailing: Button(action: {
                        saveReminder()
                        showModal.toggle()
                    }) {
                        Text("Save")
                    }
                )
            }
        }

    func saveReminder() {
        let reminderId = UUID().uuidString
        let reminder = Reminder(id: reminderId, date: date, time: time, title: title, description: description, userId: userId, isCompleted: 0)
        
        do {
            try db.collection("reminders").document(reminderId).setData(from: reminder)
            clearFields()
        } catch let error {
            print("Error writing reminder to Firestore: \(error)")
        }
    }
    
    func clearFields() {
        date = Date()
        time = Date()
        title = ""
        description = ""
    }
}
