//
//  HomeView.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 8.07.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedReminder: Reminder?
    @State private var editingReminder = Reminder(id: "", date: Date(), time: Date(), title: "", description: "", userId: "", isCompleted: 0)
    @State private var showModal = false
    @State private var showPopup = false
    @State private var date = Date()
    @State private var time = Date()
    @State private var title = ""
    @State private var description = ""
    @State private var selectedStatus: Int = 0 // 0: Not Completed, -1: Overdue, 1: Completed

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Text("\(viewModel.name) \(viewModel.surname)")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Picker("Select Status", selection: $selectedStatus) {
                        Text("Not Completed").tag(0)
                        Text("Overdue").tag(-1)
                        Text("Completed").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    List {
                        ForEach(filteredReminders) { reminder in
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
                    .onAppear {
                        viewModel.fetchUserInfo()
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
                .navigationTitle("Welcome")
            }
            
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showPopup = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding()
                                .foregroundColor(.blue)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .offset(x: -10, y: 90)
                        .sheet(isPresented: $showPopup) {
                            PopupView(showModal: $showPopup, date: $date, time: $time, title: $title, description: $description, userId: userManager.userId)
                        }
                    }
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

    private var filteredReminders: [Reminder] {
        viewModel.reminders.filter { $0.isCompleted == selectedStatus }
    }
}


