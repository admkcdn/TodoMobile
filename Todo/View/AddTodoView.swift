//
//  AddTodoView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI

struct AddTodoView: View {
    @ObservedObject var todoController = TodoController()
    @Binding var isShowingAddSheet: Bool
    
    var body: some View {
        VStack{
            Text("Naber")
            Button{
                isShowingAddSheet.toggle()
                print(todoController.addTodo(text: "Eklee"))
//                todoController.fetchTodo()
            }label: {
                Text("Ekle")
                
            }
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView( isShowingAddSheet: .constant(true))
    }
}
