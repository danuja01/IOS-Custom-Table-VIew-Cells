//
//  APIError.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 5/15/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
    case decodingError
    // Add more error cases as needed
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError:
            return "Network error occurred"
        case .decodingError:
            return "Decoding error occurred"
        }
    }
}
