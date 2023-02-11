//
//  DataStore.swift
//  TaskListApp
//
//  Created by beardmikle on 08.02.2023.//


import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}



