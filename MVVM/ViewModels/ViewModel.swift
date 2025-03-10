//
//  ViewModel.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation

protocol ViewModelOutput: AnyObject {
    func updateView(userList: [User])
}

class ViewModel {

    weak var output: ViewModelOutput?
    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func fetchUser() {
        userService.fetchUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.output?.updateView(userList: user)
            case .failure:
                print("failed to fetch user")
                self.output?.updateView(userList: [])
            }
        }
    }
}
