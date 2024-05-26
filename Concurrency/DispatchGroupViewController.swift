//
//  DispatchGroupViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class DispatchGroupViewController: UIViewController {
    
    var imageArray = [UIImageView]()
    var images = [UIImage]()
    let imageURL = [
    "https://cdn.pixabay.com/photo/2022/01/13/07/06/house-6934544__480.jpg",
    "https://cdn.pixabay.com/photo/2022/11/29/08/54/race-car-7624025__480.jpg",
    "https://cdn.pixabay.com/photo/2022/03/03/17/53/thuja-7045798__480.jpg",
    "https://cdn.pixabay.com/photo/2021/12/30/22/08/presents-6904620__480.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 200, height: 200)))
        imageArray.append(UIImageView(frame: CGRect(x: 200, y: 100, width: 200, height: 200)))
        imageArray.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 200, height: 200)))
        imageArray.append(UIImageView(frame: CGRect(x: 200, y: 300, width: 200, height: 200)))
        
        for image in imageArray {
            self.view.addSubview(image)
        }
        
        asyncGroup()
    }
    
    private func asyncGroup() {
        let groupAsync = DispatchGroup()
        
        for i in 0...3 {
            groupAsync.enter()
            guard let url = URL(string: imageURL[i]) else { return }
            asyncLoadImage(imageURL: url, queue: .global(), complitionQueue: .main) { (result, error) in
                if let image = result {
                    self.images.append(image)
                    groupAsync.leave()
                    
                }
            }
        }
        
        groupAsync.notify(queue: .main) {
            for i in 0...3 {
                self.imageArray[i].image = self.images[i]
            }
        }
    }
    
    private func asyncLoadImage(imageURL: URL, queue: DispatchQueue, complitionQueue: DispatchQueue, comlition: @escaping (UIImage?, Error?) -> () ) {
        
        queue.async {
            do {
                let data = try Data(contentsOf: imageURL)
                complitionQueue.async {
                    comlition(UIImage(data: data), nil)
                }
            } catch let error {
                complitionQueue.async {
                    comlition(nil, error)
                }
            }
        }
    }
    
}
