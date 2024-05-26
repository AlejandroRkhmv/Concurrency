//
//  Barier.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class Barier: UIViewController {
    
    let alphabetLetters = UInt32("a") ... UInt32("z")
    
    let englishArray = Alphabet<Character>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alphabet = String(String.UnicodeScalarView(alphabetLetters.compactMap(UnicodeScalar.init)))
        
        print(englishArray.showAlphabet.count)
        for char in alphabet {
            print(englishArray.showAlphabet)
            englishArray.fillAlphabet(char)
        }

        print(englishArray.showAlphabet)
        print(englishArray.showAlphabet.count)
    }
    
}

class Alphabet<T> {

    private var alphArray = [T]()
    private let concurrentQueue = DispatchQueue(label: "myQueue", attributes: .concurrent)

    public func fillAlphabet(_ char: T) {

        concurrentQueue.async(flags: .barrier) {
            self.alphArray.append(char)
        }
    }

    public var showAlphabet: [T] {
        var result = [T]()

        concurrentQueue.sync {
            result = self.alphArray
        }
        return result
    }
}
