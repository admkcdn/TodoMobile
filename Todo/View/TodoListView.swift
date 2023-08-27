//
//  TodoListView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI

struct TodoListView: View {
    @State private var isShowingAddSheet: Bool = false
    @StateObject var vm = TodoViewModel()
    
    var body: some View {
        NavigationView{
            List(vm.todos){ todo in
                NavigationLink{
                    TodoDetailView(todo: todo)
                        .navigationBarTitleDisplayMode(.inline)
//                        .padding(.trailing)
//                        .edgesIgnoringSafeArea(.all)
                }label: {
                    ToDoRowView(todo: todo)
                }
            }
            .task {
                await vm.getTodos()
            }
            .navigationTitle("Todo List")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        isShowingAddSheet.toggle()
                    }label: {
                        Image(systemName: "plus.app")
                    }
                    .sheet(isPresented: $isShowingAddSheet){
                        AddTodoView(isShowingAddSheet: $isShowingAddSheet)
                            .presentationDetents([.large,.large])
                    }
                }
            }
        }
        .refreshable {
            do{
                Task{
                    await vm.getTodos()
                }
            }
        }
    }
}

