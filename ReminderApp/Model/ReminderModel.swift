//
//  ReminderModel.swift
//  toDoApp
//
//  Created by Berk Hatipoğlu on 3.07.2024.
//

import Foundation
 
struct Reminder: Identifiable,Encodable,Decodable {
    var id: String
    var date: Date
    var time: Date
    var title: String
    var description: String
    var userId: String
    var isCompleted: Int // 0: Not completed, -1: Overdue, 1: Completed
}
