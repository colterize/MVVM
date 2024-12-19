//
//  CustomTableViewCell.swift
//  MVVM
//
//  Created by Yani . on 19/12/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with data: User) {
        fetchImage(with: data.avatar)
        userImage.backgroundColor = .lightGray
        userImage.tintColor = .darkGray
        userImage.contentMode = .scaleToFill
        nameLabel.text = "\(data.first_name) \(data.last_name)"
    }

    private func fetchImage(with stringUrl: String) {
        APIManager.shared.fetchImage(with: stringUrl) { result in
            switch result {
            case .success(let image):
                self.userImage.image = UIImage(data: image)
            case.failure(_):
                self.userImage.image = UIImage(systemName: "person.fill")
            }
        }
    }
}
