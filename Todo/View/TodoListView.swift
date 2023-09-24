//
//  TodoListView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI
import AlertKit

struct TodoListView: View {
    @State private var isShowingAddSheet: Bool = false
    @StateObject var vm = TodoViewModel()
    @State private var storedData = ""
    @StateObject var todoListManager = TodoListManager()
   
    var body: some View {
        NavigationView{
            List{
                ForEach(Array(todoListManager.todoItems.enumerated()), id: \.element.id){ index, todo in
                    NavigationLink{
                        TodoDetailView(todo: todo)
                            .navigationBarTitleDisplayMode(.inline)
                            
    //                        .padding(.trailing)
    //                        .edgesIgnoringSafeArea(.all)
                    }label: {
                        ToDoRowView(todo: todo)
                    }
                    .swipeActions(edge: .leading,allowsFullSwipe: true){
                        Button{
                            print("Silindii")
                            todoListManager.delete(index:index)
                        }label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    .swipeActions(edge: .trailing,allowsFullSwipe: true){
                        if !todo.progress{
                            Button{
                                todoListManager.makeDone(index: index)
                            }label: {
                                Image(systemName: "checkmark.seal")
                            }
                            .tint(.green)
                        }
                    }
                    
                }
            }
            .navigationTitle("Todos")
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
        .onAppear{
            todoListManager.refresh()
        }
        .refreshable {
//            TODO: haptic feedback ekle
            todoListManager.refresh()
        }
    }
}


struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

