//
//  Todo.swift
//  Todo
//
//  Created by Adem Koçdoğan on 27.08.2023.
//

import Foundation
import SwiftUI

struct Todo: Codable, Identifiable {
    var id: Double
    var title: String
    var description: String
    var progress: Bool
//    var createAt: Date
//    var updateAt: Date
    
    func getProgressIcon() -> some View {
        self.progress ?
        Image(systemName: "checkmark.circle").foregroundColor(.green)
        :
        Image(systemName: "xmark.circle").foregroundColor(.red)
    }
}

enum APIError: Error{
    case invalidUrl, requestError, decodingError, statusNotOk
}

let BASE_URL: String = "http://localhost:8001/v1/api"

struct APIService {
    
    func getTodos() async throws -> [Todo] {
        
        guard let url = URL(string:  "\(BASE_URL)/todo") else{
            throw APIError.invalidUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIError.statusNotOk
        }
        
        guard let result = try? JSONDecoder().decode([Todo].self, from: data) else {
            throw APIError.decodingError
        }
        
        return result
    }
    
}
