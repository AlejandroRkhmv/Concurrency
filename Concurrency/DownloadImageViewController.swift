//
//  DownloadImageViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class DownloadImageViewController: UIViewController {
    
    let imageView = UIImageView()
    let buttonGCD = UIButton()
    let buttonASAW = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addImageOnView()
        addButtonGCDOnView()
        addActionGCDButton()
        addButtonASAWOnView()
        addActionASAWButton()
    }
    
    
    private func addImageOnView() {
        imageView.frame = CGRect(x: 0, y: 0, width: 600, height: 500)
        imageView.center = view.center
        self.view.addSubview(imageView)
    }
    
    private func addButtonGCDOnView() {
        buttonGCD.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        buttonGCD.center = CGPoint(x: self.view.center.x, y: self.view.bounds.maxY - 140)
        buttonGCD.backgroundColor = .black
        buttonGCD.setTitle("GCD", for: .normal)
        buttonGCD.setTitleColor(.white, for: .normal)
        buttonGCD.layer.cornerRadius = 10
        
        self.view.addSubview(buttonGCD)
    }
    
    private func addActionGCDButton() {
        let action = UIAction { _ in
            self.imageView.image = nil
            self.loadImage()
        }
        buttonGCD.addAction(action, for: .touchUpInside)
    }
    
    private func loadImage() {
        if let imageURL = URL(string: "https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg") {
            
            let globalQueue = DispatchQueue.global(qos: .userInitiated)
            
            globalQueue.async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func addButtonASAWOnView() {
        buttonASAW.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        buttonASAW.center = CGPoint(x: self.view.center.x, y: self.view.bounds.maxY - 70)
        buttonASAW.backgroundColor = .black
        buttonASAW.setTitle("ASAW", for: .normal)
        buttonASAW.setTitleColor(.white, for: .normal)
        buttonASAW.layer.cornerRadius = 10
        
        self.view.addSubview(buttonASAW)
    }
    
    private func addActionASAWButton() {
        let action = UIAction { _ in
            self.imageView.image = nil
            Task {
                do {
                    let data = try await self.loadImage()
                    self.imageView.image = UIImage(data: data)
                } catch LoadImageErrors.canNotCreateURL {
                    print("Error canNotCreateURL")
                }
            }
        }
        buttonASAW.addAction(action, for: .touchUpInside)
    }
    
    private func loadImage() async throws -> Data {
        guard let url = URL(string: "https://images.pexels.com/photos/1645668/pexels-photo-1645668.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500") else {
            throw LoadImageErrors.canNotCreateURL }
        let request = URLRequest(url: url)
        let data = try await URLSession.shared.data(for: request)
        return data.0
        
    }
    
}

enum LoadImageErrors: Error {
    case canNotCreateURL
}
