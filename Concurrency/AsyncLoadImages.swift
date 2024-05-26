//
//  DispatchGroupViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class AsyncLoadImages: UIViewController {
    
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
        
        Task {
            await asyncGroup()
        }
    }
    
    private func asyncGroup() async {
        
        for i in 0...3 {
            guard let url = URL(string: imageURL[i]) else { return }
            do {
                let image = try await asyncLoadImage(imageURL: url)
                self.images.append(image)
            } catch ImageErrors.cannotCrateImageFromData {
                print("cannot create image from data")
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        
        
            for i in 0...3 {
                self.imageArray[i].image = self.images[i]
            }
        
    }
    
    
    private func asyncLoadImage(imageURL: URL) async throws -> UIImage {
        let request = URLRequest(url: imageURL)
        let data = try await URLSession.shared.data(for: request)
        guard let image = UIImage(data: data.0) else { throw ImageErrors.cannotCrateImageFromData }
        return image

    }
    
}

enum ImageErrors: Error {
    case cannotCrateImageFromData
}
