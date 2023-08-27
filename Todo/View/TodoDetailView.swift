//
//  TodoDetailView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI

struct TodoDetailView: View {
    @State var todo: Todo
    
    var body: some View {
        VStack{
            List{
                Section{
                    TextField("Başlık", text: $todo.title)
                    TextField("Açıklama", text: $todo.description, axis: .vertical)
                } footer: {
                    HStack{
//                        Text("Oluşturma Tarihi: \(Formatter.dateFormat.string(from: todo.createAt))")
                    }
                }
            }
            .scrollDisabled(true)
            .toolbar{
                Button{
                    
                }label: {
                    Image(systemName: "pencil.line")
                    Text("Kaydet")
                }
            }
            
        }
    }
}

extension Formatter{
    static let dateFormat : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(todo: Todo(id: 1, title: "Market Alışverişi", description: "Yumurta, zeytin al ne varsa al cips al yarış izlenecek", progress: true))
    }
}
