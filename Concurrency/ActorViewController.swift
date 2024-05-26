//
//  ActorViewController.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class ActorViewController: UIViewController {
    
    let russianLetters = UInt32("а") ... UInt32("я")
    
    
    let rusArray = RusAlphabet<Character>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let russianAlphabet = String(String.UnicodeScalarView(russianLetters.compactMap(UnicodeScalar.init)))
        
        Task {
            for char in russianAlphabet {
                await rusArray.fillAlphabet(char)
            }
            
            print(await rusArray.showAlphabet)
            print(await rusArray.count)
        }
        
    }
    
}

actor RusAlphabet<T> {

    private var alphArray = [T]()

    func fillAlphabet(_ char: T) {
        self.alphArray.append(char)
    }

    var showAlphabet: [T] {
        var result = [T]()
        result = self.alphArray
        return result
    }
    
    var count: Int {
        return self.alphArray.count
    }
}


//extension String: AsyncSequence {
//    public struct AsyncIterator: AsyncIteratorProtocol {
//        private var currentIndex: String.Index
//        private let string: String
//        
//        fileprivate init(string: String) {
//            self.string = string
//            currentIndex = string.startIndex
//        }
//        
//        public mutating func next() async throws -> Character? {
//            guard currentIndex < string.endIndex else { return nil }
//            
//            let char = string[currentIndex]
//            currentIndex = string.index(after: currentIndex)
//            return char
//        }
//    }
//    
//    public func makeAsyncIterator() -> AsyncIterator {
//        return AsyncIterator(string: self)
//    }
//}
