//
//  User.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation

struct User: Decodable {
    let id: Int
    let email: String
    let avatar: String
    let first_name: String
    let last_name: String
}
