//
//  ErrorModel.swift
//  collection
//
//  Created by Larissa Lanes on 22/09/23.
//

import Foundation

enum Errors {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}
