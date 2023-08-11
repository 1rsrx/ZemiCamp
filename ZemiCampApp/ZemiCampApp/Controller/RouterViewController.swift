//
//  ViewController.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

struct NextViewControllerInfo {
    var title: String
    var viewController: UIViewController
}

class RouterViewController: UIViewController {
    
    @IBOutlet weak var routerTableView: UITableView!
    
    private var controllers: [NextViewControllerInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpControllers()
        setUpView()
    }
    
    private func setUpControllers() {
        let imageLoadViewController = UIStoryboard(name: "ImageLoadViewController", bundle: nil).instantiateInitialViewController()!
        let jsonLoadViewController = UIStoryboard(name: "JsonLoadViewController", bundle: nil).instantiateInitialViewController()!
        
        
        controllers = [
            NextViewControllerInfo(title: "画像", viewController: imageLoadViewController),
            NextViewControllerInfo(title: "JSON", viewController: jsonLoadViewController)
        ]
    }

    private func setUpView() {
        routerTableView.dataSource = self
        routerTableView.delegate = self
        routerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "routerTableViewCell")
    }
}

extension RouterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routerTableViewCell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = controllers[indexPath.row].title
        cell.contentConfiguration = config
        
        return cell
    }
}

extension RouterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = controllers[indexPath.row].viewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
