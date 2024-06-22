//
//  SearchView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 11.07.2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = SearchViewModel()
    @State private var showModal = false
    @State private var editingReminder = Reminder(id: "", date: Date(), time: Date(), title: "", description: "", userId: "", isCompleted: 0)

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                    customTextField(title: "", text: $viewModel.searchText)
                }
                .padding(.horizontal, 20)
                
                List {
                    ForEach(viewModel.filteredReminders) { reminder in
                        ReminderRowView(
                            reminder: .constant(reminder),
                            onUpdate: { updatedReminder in
                                viewModel.updateReminder(updatedReminder)
                            },
                            onDelete: { deletedReminder in
                                viewModel.deleteReminder(deletedReminder)
                            }
                        )
                        .onTapGesture {
                            editingReminder = reminder
                            showModal = true
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .onAppear {
                viewModel.fetchReminders()
            }
            .sheet(isPresented: $showModal) {
                ReminderDetailView(showModal: $showModal, reminder: $editingReminder, onSave: { updatedReminder in
                    if let index = viewModel.reminders.firstIndex(where: { $0.id == updatedReminder.id }) {
                        viewModel.reminders[index] = updatedReminder
                    } else {
                        viewModel.reminders.append(updatedReminder)
                    }
                    viewModel.updateReminder(updatedReminder)
                })
            }
        }
    }
}

