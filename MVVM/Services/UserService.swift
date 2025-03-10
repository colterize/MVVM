//
//  UserService.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation

protocol UserService {
    func fetchUser(completion: @escaping (Result<[User], Error>) -> Void)
}
