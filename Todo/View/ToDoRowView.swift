//
//  ToDoRowView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI

struct ToDoRowView: View {
    var todo: Todo
    
    
    var body: some View {
        HStack{
            todo.getProgressIcon()
            Text(todo.title)
            Spacer()
        }
    }
}

struct ToDoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoRowView(todo: Todo(id: 1, title: "Market Alışverişi", description: "Yumurta, zeytin al", progress: false))
    }
}
