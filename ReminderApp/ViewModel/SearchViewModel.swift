//
//  SearchViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 11.07.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

class SearchViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    @Published var searchText: String = ""
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchReminders()
    }

    var filteredReminders: [Reminder] {
        if searchText.isEmpty {
            return reminders
        } else {
            return reminders.filter { reminder in
                reminder.title.localizedCaseInsensitiveContains(searchText) ||
                reminder.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func fetchReminders() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("reminders")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching reminders: \(error.localizedDescription)")
                    return
                }

                self?.updateReminders(snapshot: snapshot)
            }
    }

    private func updateReminders(snapshot: QuerySnapshot?) {
        let now = Date()
        var updatedReminders = [Reminder]()

        snapshot?.documents.forEach { document in
            guard var reminder = try? document.data(as: Reminder.self) else { return }

            let reminderDateTime = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: reminder.time),
                                                        minute: Calendar.current.component(.minute, from: reminder.time),
                                                        second: 0,
                                                        of: reminder.date) ?? reminder.date

            if reminder.isCompleted == 0 && reminderDateTime < now {
                reminder.isCompleted = -1
                updateReminder(reminder)
            }

            updatedReminders.append(reminder)
        }

        DispatchQueue.main.async {
            self.reminders = updatedReminders
        }
    }

    func updateReminder(_ reminder: Reminder) {
        do {
            try db.collection("reminders").document(reminder.id).setData(from: reminder)
        } catch {
            print("Error updating reminder: \(error.localizedDescription)")
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        db.collection("reminders").document(reminder.id).delete { error in
            if let error = error {
                print("Error deleting reminder: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.reminders.removeAll { $0.id == reminder.id }
                }
            }
        }
    }
}
