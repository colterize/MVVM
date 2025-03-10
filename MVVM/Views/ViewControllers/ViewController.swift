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

    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.viewModel.output = self
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
        let imageService: ImageService = APIManager()
        let viewModel = UserCellViewModel(user: userList[indexPath.row], imageService: imageService)
        cell.configure(viewModel: viewModel)
        cell.configureContent()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageService : ImageService = APIManager()
        let viewModel = DetailUserViewModel(user: userList[indexPath.row], imageService: imageService)
        let vc = DetailUserViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
