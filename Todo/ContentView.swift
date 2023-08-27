//
//  ContentView.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var todoController = TodoController()
    var body: some View {
        TodoListView()
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
