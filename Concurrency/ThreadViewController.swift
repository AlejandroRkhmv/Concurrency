//
//  ThreadViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class ThreadViewController: UIViewController {

    var firstThread = Thread() {
        for i in 0...10000 {
            print("This is the first thread \(i)")
        }
        print(Thread())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstThread.name = "FirstThread"
        firstThread.start()
        print("isMainThread \(firstThread.isMainThread)")
        
        print("isExecuting \(firstThread.isExecuting)")
        
        print("name \(firstThread.name ?? "Unnown")")
        
        print("isCancelled \(firstThread.isCancelled)")
        //firstThread.cancel()
        print("isCancelled \(firstThread.isCancelled)")
        
        
        print(firstThread.isFinished)
        sleep(5)
        print(firstThread.isFinished)
        
        firstThread.qualityOfService = .userInteractive
        firstThread.threadPriority = 1
        print("isMainThread \(firstThread.isMainThread)")
        
    }


}
