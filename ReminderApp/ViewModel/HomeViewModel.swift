//
//  HomeViewModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 8.07.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

class HomeViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    @Published var id: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    
    init() {
        fetchReminders()
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

    func fetchUserInfo() {
        if let user = Auth.auth().currentUser {
            self.id = user.uid
            db.collection("users").whereField("id", isEqualTo: self.id).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    if let document = querySnapshot?.documents.first {
                        let data = document.data()
                        self.name = data["name"] as? String ?? ""
                        self.surname = data["surname"] as? String ?? ""
                    }
                }
            }
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

