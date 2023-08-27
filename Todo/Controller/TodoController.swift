//
//  TodoController.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import UIKit

class TodoController: ObservableObject{
    var todomanager = TodoManager()
    func addTodo(text: String) -> Bool {
        print(text)
        return true
    }
    
    func fetchTodo() -> [Todo]?{
        return todomanager.fetchTodo()
    }
}

