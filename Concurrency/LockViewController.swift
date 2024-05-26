//
//  LockViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class LockViewController: UIViewController {
    
    var someArray = ["a", "b", "c", "d"]
    let safetyThread = SafetyThread()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let one = Thread {

            self.safetyThread.someMethod {
                self.someArray.append("10")
            }
        }

        let two = Thread {
            self.safetyThread.someMethod {
                for i in self.someArray {
                    print(i)
                }
            }
        }

        let three = Thread {
            self.safetyThread.someMethod {
                self.someArray[0] = "123"
                print(self.someArray)
            }
        }
        
        
        
        one.start()
        two.start()
        //sleep(4)
        three.start()
        
    }
    
    
}

// MARK: - SafetyThread
class SafetyThread {
    private let lockMutex = NSLock()

    func someMethod(closure: () -> ()) {

        lockMutex.lock()
        closure()
        lockMutex.unlock()
        
    }
}
