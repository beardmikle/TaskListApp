//
//  ContentView.swift
//  TaskListApp
//
//  Created by beardmikle on 08.02.2023.
//

import SwiftUI
import Combine


let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [.indigo, .purple]),
    startPoint: .top, endPoint: .bottom)


struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.green]
    }
    
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo: String = ""
    

    
    
    var searchBar : some View {
        HStack {
            TextField("Enter in a new task", text: self.$newToDo)
                .padding([.bottom, .all], 6)
                .border(Color.green, width: 2)
                .foregroundColor(.green)
                
            Button(action: self.addNewToDo , label: {
                Text("Add New")
                    .accentColor(.green)
                    .fontWeight(.bold)
                
            })
            .buttonStyle(.bordered)
            .background(Color.blue)
            .cornerRadius(20)
        
           
        }
    }
    
    func addNewToDo() {
        taskStore.tasks.append(Task(id:String(taskStore.tasks.count + 1), toDoItem: newToDo))
        self.newToDo = ""
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {
                    searchBar.padding()
                    List {
                        ForEach(self.taskStore.tasks) {
                            task in
                            Text(task.toDoItem)
                                .listRowBackground(Rectangle()
                                    .foregroundColor(.green)
                                    .opacity(0.5)
                                )
                        }
                        
                        .onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                    }
                    .scrollContentBackground(.hidden)
                    
                    .navigationBarTitle("What to do:")
                    .navigationBarItems(trailing: EditButton()
                        .padding(.all)
                        .font(.system(size: 20))
                        .accentColor(.red)
                        .fontWeight(.bold))
                        
                }
            }
        }
    }
    
    
    func move (from source: IndexSet, to destination: Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete ( at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
    

}


    
