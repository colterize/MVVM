//
//  DetailUserViewModel.swift
//  MVVM
//
//  Created by Yani . on 21/02/25.
//

import Foundation
import UIKit

protocol DetailViewModelOutput: AnyObject {
    func updateImage(image: UIImage)
}

class DetailUserViewModel {

    weak var output: DetailViewModelOutput?
    let user: User
    private let imageService: ImageService

    init(user: User, imageService: ImageService) {
        self.user = user
        self.imageService = imageService
    }

    func fetchImage() {
        imageService.fetchImage(with: user.avatar) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.output?.updateImage(image: UIImage(data: image) ?? UIImage())
            case .failure:
                self.output?.updateImage(image: UIImage(systemName: "person.fill") ?? UIImage())
            }
        }
    }
}
