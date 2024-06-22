//
//  PageModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 23.06.2024.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var animationName: String
    var tag: Int
    
    static var samplePages: [Page] = [
        Page(name: "Plan Your Schedule", description: "Organize your tasks and reminders to always know what you need to do.", animationName: "calendar", tag: 0),
        Page(name: "Reminders and Notifications", description: "With reminders and notifications, you will always receive timely alerts.", animationName: "reminder", tag: 1),
        Page(name: "User-Friendly Interface", description: "Easily access all the features you need. Adding, editing, and completing tasks is just a few clicks away.", animationName: "userfriendly", tag: 2)

    ]
}
