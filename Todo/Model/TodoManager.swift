//
//  TodoManager.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import Foundation
import SwiftUI

protocol TodoManagerDelegate{
    func didUpdateTodo(_ todoManager: TodoManager,todos : [Todo])
}

struct TodoManager{
    let url = "http://localhost:8001/v1/api/todo"
    
    var delegate: TodoManagerDelegate?
    
    func fetchTodo() -> [Todo]?{
        var todos: [Todo]? = []
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){data, response, error in
                let safeData = data
                if let safeTodo = parseJson(safeData!){
                todos = safeTodo
                }
                print("safeDataDeğil")
            }
            task.resume()
            return todos
        }
        return nil
    }
    
    func parseJson(_ todoData: Data) -> [Todo]?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([Todo].self, from: todoData)
            return decodedData
        }catch{
            print("aga Noluyo")
            print(error)
            return nil
        }
    }
}
