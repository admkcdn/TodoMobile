//
//  AddTodoView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI
import AlertKit

struct AddTodoView: View {
    @ObservedObject var todoController = TodoController()
    @StateObject var todoListManager = TodoListManager()
    @Binding var isShowingAddSheet: Bool
    @State private var title: String = ""
    @State private var description: String = ""
    
    @FocusState private var focusedField: FormField?
    enum FormField{
        case title, description
    }
    
    private func addTodo(){
        if self.title.trimmingCharacters(in: .whitespacesAndNewlines) != "" && self.description != "".trimmingCharacters(in: .whitespacesAndNewlines){
            todoListManager.add(todo: Todo(id: Double(todoListManager.todoItems.count+1), title: $title.wrappedValue, description: $description.wrappedValue, progress: false))
            isShowingAddSheet = false
            todoListManager.refresh()
        }else{
            AlertKitAPI.present(
                title: "Tüm Boşlukları doldurduğunuza emin olun!",
                icon: .error,
                style: .iOS17AppleMusic,
                haptic: .error
            )
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                List{
                    Text("Başlık")
                        .font(.headline)
                        .listRowSeparator(.hidden)
                    TextField("Başlık", text: $title)
                        .textFieldStyle(.plain)
                        .listRowSeparator(.visible)
                        .submitLabel(.next)
                        .focused($focusedField,equals: .title)
                        .onSubmit {
                            determineField()
                        }
                    
                    Text("Açıklama")
                        .font(.headline)
                        .listRowSeparator(.hidden)
                    TextField("Açıklama", text: $description)
                        .submitLabel(.send)
                        .focused($focusedField,equals: .description)
                        .onSubmit {
                            determineField()
                        }
                }
                .scrollDisabled(true)
               
            }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                            Button{
                                print("Button was pressed")
//                                save(data: $title.wrappedValue)
                               addTodo()
                            }label: {
                                Text("Add")
                            }
                    }//MARK: TOOLBARITEM
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            print("Button was pressed")
                            isShowingAddSheet = false
                        }label: {
                            Text("Vazgeç")
                        }
                    }
                }//MARK: TOOLBAR
        }//MARK: NAVIGATONSTACK
    }
    
    func determineField(){
        switch focusedField{
        case .title:
            focusedField = .description
        case .description:
            focusedField = nil
            addTodo()
        default:
            focusedField = nil
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView( isShowingAddSheet: .constant(true))
    }
}
