//
//  ViewController.swift
//  MVVM
//
//  Created by Yani . on 17/12/24.
//

import UIKit

class ViewController: UIViewController, ViewModelOutput {

    @IBOutlet var tableView: UITableView!

    private var viewModel: ViewModel!
    private var imageService: ImageService!

    func configure(viewModel: ViewModel, imageService: ImageService) {
        self.viewModel = viewModel
        self.viewModel.output = self
        self.imageService = imageService
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var userList: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchUsers()
        self.title = "List User"
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func fetchUsers() {
        viewModel.fetchUser()
    }

    // MARK: - ViewModelOutput
    func updateView(userList: [User]) {
        self.userList = userList
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        let viewModel = UserCellViewModel(user: userList[indexPath.row], imageService: imageService)
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = DetailUserViewModel(user: userList[indexPath.row], imageService: imageService)
        let vc = DetailUserViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
