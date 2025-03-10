//
//  UserCellViewModel.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation
import UIKit

protocol UserCellViewModelOutput: AnyObject {
    func updateData(name: String, image: UIImage)
}

class UserCellViewModel {
    
    weak var output: UserCellViewModelOutput?
    let user: User
    private let imageService: ImageService

    init(user: User, imageService: ImageService) {
        self.user = user
        self.imageService = imageService
    }

    func fetchData() {
        let name = "\(user.first_name) \(user.last_name)"
        imageService.fetchImage(with: user.avatar) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.output?.updateData(name: name, image: UIImage(data: image) ?? UIImage())
            case .failure:
                self.output?.updateData(name: name, image: UIImage(systemName: "person.fill") ?? UIImage())
            }
        }
    }
}
