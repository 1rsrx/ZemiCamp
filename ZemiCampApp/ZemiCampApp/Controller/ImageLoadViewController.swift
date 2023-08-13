//
//  ImageLoadViewController.swift
//  ZemiCampApp
//
//  Created by r on 2023/08/11.
//

import UIKit

class ImageLoadViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private let imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchImage()
        }
    }
    
    private func fetchImage() async {
        let url = URL(string: "https://3.bp.blogspot.com/-DOKddrio4pk/VA-hsHvEkcI/AAAAAAAAmTo/fe76jzUvai0/s800/smartwatch.png")!
        do {
            let image = try await imageLoader.fetchImage(from: url)
        } catch {
            if let networkError = error as? NetworkError {
                showAlert(message: networkError.localizedDescription)
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
