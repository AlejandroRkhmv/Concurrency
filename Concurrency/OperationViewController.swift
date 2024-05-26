//
//  OperationViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class OperationViewController: UIViewController {
    
    var result: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //blockOperation()
        
        //cancellOperation()
        
        //waitUntill()
        
        //waitUntill2()
        
        //completionBlockTest()
        
        concurentOperation()
    }
    
    private func blockOperation() {
        let concurrentOperation = BlockOperation {
            self.result = "Gatorz"
            if let result = self.result {
                print(result)
            }
            print(Thread.current)
        }
        
        let queue = OperationQueue()
        queue.addOperation(concurrentOperation)
    }
    
    
    private func cancellOperation() {
        let operationQueue = OperationQueue()
        
        let cancelOperation = OperationCancelTest()
        operationQueue.addOperation(cancelOperation)
        sleep(1)
        //cancelOperation.cancel()
    }
    
    private func waitUntill() {
        let wait = WaitOperationTest()
        wait.test()
    }
    
    private func waitUntill2() {
        let wait2 = WaitOperationTest2()
        wait2.test()
    }
    
    private func completionBlockTest() {
        let comp = ComplitionBlockTest()
        comp.test()
    }
    
    private func concurentOperation() {
        let task = ConcurentOperationSemaphore()
        task.test()
    }
}

class OperationCancelTest: Operation {
    
    override func main() {
        super.main()
        print("test 0")
        if isCancelled {
            print(isCancelled, "100")
            return
        }
        print("test 1")
        sleep(2)
        if isCancelled {
            print(isCancelled, "200")
            return
        }
        print("test 2")
    }
}

class WaitOperationTest {

    private let queue = OperationQueue()

    func test() {
        queue.addOperation {
            sleep(1)
            print("test 1")
            print(Thread.current)
        }
        queue.addOperation {
            sleep(6)
            print("test 2")
            print(Thread.current)
        }
        queue.waitUntilAllOperationsAreFinished()
        queue.addOperation {
            print("test 3")
            print(Thread.current)
        }
        queue.addOperation {
            print("test 4")
            print(Thread.current)
        }
    }
}

class WaitOperationTest2 {

    private let queue = OperationQueue()

    func test() {
        let operationOne = BlockOperation {
            sleep(1)
            print("test 1")
            print(Thread.current)
        }
        let operationTwo = BlockOperation {
            sleep(2)
            print("test 2")
            print(Thread.current)
        }
        let operationThree = BlockOperation {
            print("test 3")
            print(Thread.current)
        }
        let operationFour = BlockOperation {
            print("test 4")
            print(Thread.current)
        }

        queue.addOperations([operationOne, operationTwo], waitUntilFinished: true)
        queue.addOperations([operationThree, operationFour], waitUntilFinished: false)
    }
}


class ComplitionBlockTest {
    private let queue = OperationQueue()

    func test() {
        let blockOperation = BlockOperation {
            sleep(3)
            print("test of complition block")
            print(Thread.current)
        }

        blockOperation.completionBlock = {
            print("finish")
            print(Thread.current)
        }

        queue.addOperation(blockOperation)
    }
}


class ConcurentOperationSemaphore {

    private let queue = OperationQueue()

    public func test() {

        let blockOperationOne = BlockOperation {
            sleep(1)
            print("block one")
            print(Thread.current)
        }
        let blockOperationTwo = BlockOperation {
            sleep(1)
            print("block two")
            print(Thread.current)
        }
        let blockOperationThree = BlockOperation {
            sleep(1)
            print("block three")
            print(Thread.current)
        }
        let blockOperationFour = BlockOperation {
            sleep(1)
            print("block four")
            print(Thread.current)
        }
        let blockOperationFive = BlockOperation {
            sleep(1)
            print("block five")
            print(Thread.current)
        }

        queue.maxConcurrentOperationCount = 3
        queue.addOperations([blockOperationOne, blockOperationTwo, blockOperationThree, blockOperationFour, blockOperationFive], waitUntilFinished: false)
    }
}


