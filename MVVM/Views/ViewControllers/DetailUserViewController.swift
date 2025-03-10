//
//  DetailUserViewController.swift
//  MVVM
//
//  Created by Yani . on 19/12/24.
//

import UIKit

class DetailUserViewController: UIViewController, DetailViewModelOutput {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    private var viewModel: DetailUserViewModel

    init(viewModel: DetailUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.backgroundColor = .lightGray
        userImage.tintColor = .darkGray
        userImage.contentMode = .scaleToFill
        configureData(with: viewModel)
    }

    private func fetchImage() {
        viewModel.fetchImage()
    }

    private func configureData(with viewModel: DetailUserViewModel) {
        nameLabel.text = "\(viewModel.user.first_name) \(viewModel.user.last_name)"
        emailLabel.text = viewModel.user.email
        fetchImage()
    }

    // MARK: - DetailViewModelOutput
    func updateImage(image: UIImage) {
        self.userImage.image = image
    }

}
