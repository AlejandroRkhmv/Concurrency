//
//  SemaphoreViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class SemaphoreViewController: UIViewController {
    
    var array = [10, 11, 12, 13]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        semaphorePerform()
    }
    
    private func semaphorePerform() {
        let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

        let semaphore = DispatchSemaphore(value: 0)
        semaphore.signal() // value + 1

        concurrentQueue.async {
            semaphore.wait() // value - 1
            for i in 0...9 {
                self.array.append(i)
            }
            semaphore.signal() // value + 1
        }

        concurrentQueue.async {
            semaphore.wait() // value - 1
            print(self.array)
            semaphore.signal() // value + 1
        }

        concurrentQueue.async {
            semaphore.wait() // value - 1
            self.array.removeAll()
            semaphore.signal() // value + 1
        }
        
        concurrentQueue.async {
            semaphore.wait() // value - 1
            print(self.array)
            semaphore.signal() // value + 1
        }
        
        concurrentQueue.async {
            semaphore.wait() // value - 1
            self.array.append(12345)
            semaphore.signal() // value + 1
        }
        
        concurrentQueue.async {
            semaphore.wait() // value - 1
            print(self.array)
            semaphore.signal() // value + 1
        }
    }
    
}





