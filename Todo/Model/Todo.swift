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
    
    func updateTodoAsync(todo: Todo) async {
        let baseUrl = URL(string: BASE_URL)!
        let fullUrl = baseUrl.appendingPathComponent("/todo/\(Int(todo.id))", isDirectory: false)
        
        var request = URLRequest(url: fullUrl)
        
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        do {
            request.httpBody = try JSONEncoder().encode(todo)
        } catch let error {
            print(error.localizedDescription)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let responseJSONData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                print("Response JSON data = \(responseJSONData)")
            }
        } catch {
            print("Error making PUT request: \(error.localizedDescription)")
        }
    }
    
    func deleteTodoAsync(id:Float) async -> Bool{
        let baseUrl = URL(string: BASE_URL)!
        let fullUrl = baseUrl.appendingPathComponent("/todo/\(Int(id))",isDirectory: false)
        
        var request = URLRequest(url: fullUrl)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        do{
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            print("Başarıyla silindi.")
                            return true
                        } else {
                            print("Silme işlemi başarısız. Hata kodu: \(httpResponse.statusCode)")
                        }
                    }
        }catch{
            print(error.localizedDescription)
        }
        return false
    }
}
