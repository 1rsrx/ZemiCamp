//
//  JsonViewController.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit
import SafariServices

class JsonLoadViewController: UIViewController {

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var repositoryTableView: UITableView!
    private let indicatorView = UIActivityIndicatorView()
    
    private let repositoryLoader = RepositoryLoader()
    
    private var repositories: [SearchRepositoryResult.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
        repositoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setUpIndicator()
    }
    
    private func setUpIndicator() {
        indicatorView.center = view.center
        indicatorView.style = .large
        view.addSubview(indicatorView)
    }
    
    @IBAction func didTapReturn(_ sender: Any) {

        repositories = []
        repositoryTableView.reloadData()
        
        Task {
            do {
                indicatorView.startAnimating()
                
                let result = try await repositoryLoader.fetchRepositories(keyword: keywordTextField.text ?? "")
                self.repositories = result.items
                repositoryTableView.reloadData()
                
                indicatorView.stopAnimating()
            } catch {
                showAlert(message: error.localizedDescription)
                indicatorView.stopAnimating()
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "エラーが発生しました", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "閉じる", style: .default)
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
}

extension JsonLoadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repository = repositories[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = repository.name
        config.secondaryText = repository.html_url
        
        cell.contentConfiguration = config
        
        return cell
    }
}

extension JsonLoadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repository = repositories[indexPath.row]
        if let url = URL(string: repository.html_url) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.dismissButtonStyle = .close
            present(safariViewController, animated: true)
        }
    }
}
