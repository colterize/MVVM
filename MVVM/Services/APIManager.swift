//
//  APIManager.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation

class APIManager: UserService, ImageService {

    func fetchUser(completion: @escaping (Result<[User], Error>) -> Void) {

        let url = URL(string: "https://reqres.in/api/users?page=2")!

        URLSession.shared.dataTask(with: url) { data, res, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let user = try? JSONDecoder().decode(UserResponse.self, from: data).data {
                  completion(.success(user))
                } else {
                  completion(.failure(NSError()))
                }
            }
        }.resume()
    }

    func fetchImage(with stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: stringUrl)!

        URLSession.shared.dataTask(with: url) { data, res, error in
            DispatchQueue.main.async {
                if let imageData = data {
                    completion(.success(imageData))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }

}
