//
//  WorkItemViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class WorkItemViewController: UIViewController {
    
    let imageView = UIImageView()
    var data: Data?
    private let concurrentQueue = DispatchQueue(label: "DWIQ", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageOnView()
        
        downloadImage()
    }
    
    private func addImageOnView() {
        imageView.frame = CGRect(x: 0, y: 0, width: 600, height: 500)
        imageView.center = view.center
        self.view.addSubview(imageView)
    }
    
    private func downloadImage() {
        let imageURL = URL(string: "https://pixlr.com/images/index/ai-image-generator-one.webp")
        let workItem = DispatchWorkItem(qos: .userInitiated) {
            guard let url = imageURL else { return }
            self.data = try? Data(contentsOf: url)
            print(Thread.current)
        }
        
        let workItemAfterNotify = DispatchWorkItem {
            print(workItem.isCancelled)
            if let data = self.data {
                print(Thread.current)
                self.imageView.image = UIImage(data: data)
            }
        }
        //workItem.cancel()
        //workItem.wait(timeout: .now() + .seconds(3))
        workItem.notify(queue: DispatchQueue.main, execute: workItemAfterNotify)
        
        concurrentQueue.async(execute: workItem)
    }
}



