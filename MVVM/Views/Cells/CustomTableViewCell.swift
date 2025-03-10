//
//  CustomTableViewCell.swift
//  MVVM
//
//  Created by Yani . on 19/12/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell, UserCellViewModelOutput {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    private var viewModel: UserCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(viewModel: UserCellViewModel) {
        self.viewModel = viewModel
        self.viewModel.output = self
    }
    
    func configureContent() {
        fetchData()
        userImage.backgroundColor = .lightGray
        userImage.tintColor = .darkGray
        userImage.contentMode = .scaleToFill
    }

    private func fetchData() {
        viewModel.fetchData()
    }

    // MARK: - UserCellViewModelOutput
    func updateData(name: String, image: UIImage) {
        self.nameLabel.text = name
        self.userImage.image = image
    }
}
