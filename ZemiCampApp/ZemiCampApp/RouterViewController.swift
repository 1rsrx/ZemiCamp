//
//  ViewController.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

class RouterViewController: UIViewController {
    
    @IBOutlet weak var routerTableView: UITableView!
    
    private let titles = ["画像取得","JSON取得"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    private func setUp() {
        routerTableView.dataSource = self
        routerTableView.delegate = self
        routerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "routerTableViewCell")
    }
}

extension RouterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routerTableViewCell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = titles[indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
}

extension RouterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
