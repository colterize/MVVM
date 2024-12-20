//
//  DetailUserViewController.swift
//  MVVM
//
//  Created by Yani . on 19/12/24.
//

import UIKit

class DetailUserViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    var userData: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.backgroundColor = .lightGray
        userImage.tintColor = .darkGray
        userImage.contentMode = .scaleToFill
        if let data = userData {
            configureData(with: data)
        }
    }

    private func configureData(with data: User) {
        nameLabel.text = "\(data.first_name) \(data.last_name)"
        emailLabel.text = data.email
        APIManager.shared.fetchImage(with: data.avatar) { result in
            switch result {
            case .success(let image):
                self.userImage.image = UIImage(data: image)
            case.failure(_):
                self.userImage.image = UIImage(systemName: "person.fill")
            }
        }
    }

}
