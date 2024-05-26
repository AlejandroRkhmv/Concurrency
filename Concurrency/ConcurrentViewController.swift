//
//  ConcurrentViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class ConcurrentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myInactiveQueue()
    }
    
}




func myInactiveQueue() {
    
    let inactiveQueue = DispatchQueue(label: "inactiveQueue", attributes: [.concurrent, .initiallyInactive])
    
    inactiveQueue.async {
        print("Done!")
        print(inactiveQueue.label)
    }
    
    print("not yet started...")
    inactiveQueue.activate()
    print("I am activated!")
    inactiveQueue.suspend()
    print("Pause!")
    inactiveQueue.resume()
}
