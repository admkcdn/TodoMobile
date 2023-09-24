//
//  TodoListManager.swift
//  Todo
//
//  Created by Adem Koçdoğan on 17.09.2023.
//

import Foundation
import AlertKit
import UIKit

class TodoListManager : ObservableObject {
    @Published var todoItems: [Todo] = []
    
    init(){
        load()
    }
    
    func add(todo: Todo){
        todoItems.append(todo)
        save()
        AlertKitAPI.present(
            title: "Eklendi!",
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    func delete(index: Int){
        todoItems.remove(at: index)
        save()
        AlertKitAPI.present(
            title: "Silindi!",
            icon: .custom(UIImage(systemName: "trash")!),
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    func update(index: Int, todo:Todo){
        todoItems[index] = todo
        save()
        AlertKitAPI.present(
            title: "Güncellendi!",
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
    }
    
    func makeDone(index: Int){
        if !todoItems[index].progress {
            todoItems[index].progress = true
            save()
            AlertKitAPI.present(
                title: "Yapıldı olarak işaretlendi!",
                icon: .done,
                style: .iOS17AppleMusic,
                haptic: .success
            )
        }else{
            AlertKitAPI.present(
                title: "Hata!",
                icon: .error,
                style: .iOS17AppleMusic,
                haptic: .error
            )
        }
    }
    
    func refresh(){
        load()
    }
    
    private func save (){
        if let encodedData = try? JSONEncoder().encode(todoItems) {
            UserDefaults.standard.set(encodedData, forKey: "todoItems")
        }
    }
    
    private func load(){
        if let data = UserDefaults.standard.data(forKey:"todoItems"),
           let decodedData = try? JSONDecoder().decode([Todo].self, from: data){
            todoItems = decodedData
        }
    }
}
