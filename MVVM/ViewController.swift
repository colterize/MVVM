//
//  ViewController.swift
//  MVVM
//
//  Created by Yani . on 17/12/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var userData: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        fetchUsers()
        self.title = "List User"
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func fetchUsers() {
        APIManager.shared.fetchUser { result in
            switch result {
            case .success(let user):
                self.userData = user
                self.tableView.reloadData()
            case .failure(_):
                print("failed to fetch user")
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        if let userData = userData {
            cell.configure(with: userData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailUserViewController()
        vc.userData = userData?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


class APIManager {

    static let shared = APIManager()

    private init() {}

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

struct UserResponse: Decodable {
    let data: [User]
}

struct User: Decodable {
    let id: Int
    let email: String
    let avatar: String
    let first_name: String
    let last_name: String
}
