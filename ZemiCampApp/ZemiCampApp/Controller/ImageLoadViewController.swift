//
//  ImageLoadViewController.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

class ImageLoadViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    private let indicatorView = UIActivityIndicatorView()
    
    private let imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpIndicator()
    }
    
    private func setUpIndicator() {
        indicatorView.center = view.center
        indicatorView.style = .large
        view.addSubview(indicatorView)
    }
    
    @IBAction func didTapReturn(_ sender: Any) {
        let encoded = urlTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: encoded) else {
            showAlert(message: "無効なURLです")
            return
        }
        
        Task {
            do {
                indicatorView.startAnimating()
                
                let image = try await imageLoader.fetchImage(from: url)
                if let image = image {
                    imageView.image = image
                    indicatorView.stopAnimating()
                } else {
                    indicatorView.stopAnimating()
                    showAlert(message: "画像がnil")
                }
            } catch {
                indicatorView.stopAnimating()
                showAlert(message: error.localizedDescription)
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
