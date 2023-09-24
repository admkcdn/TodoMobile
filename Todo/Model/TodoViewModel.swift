//
//  TodoViewModel.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//


import Foundation

@MainActor
class TodoViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var errorMessage = ""
    @Published var hasError = false
    
    
    func getTodos() async {
        guard let data = try?  await  APIService().getTodos() else {
            self.todos = []
            self.hasError = true
            self.errorMessage  = "Server Error"
            return
        }
        self.todos = data
    }
    
    func updateTodo(todo: Todo) async{
        await APIService().updateTodoAsync(todo: todo)
        await self.getTodos()
    }
    
    func deleteTodo(id: Float) async -> Bool{
        if await APIService().deleteTodoAsync(id: id){
            await self.getTodos()
            return true
        }else {
            return false
        }
    }
}
