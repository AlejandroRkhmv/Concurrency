//
//  AsyncLet.swift
//  Concurrency
//
//  Created by Александр Рахимов on 26.05.2024.
//

import UIKit

final class AsyncLetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            async let cucumbers = returnCucumbers()
            async let tomatos = returnTomatos()
            async let cream = returnCream()
            
            let salad = await (cucumbers + tomatos + cream)
            print(salad)
        }
        
        Task {
            async let water = buynWater()
            async let coffee = buynCoffee()
            async let milk = buynMilk()
            
            let cappuchino = await makeCappuchino(water: water, coffee: coffee, milk: milk)
            await makeBrave(cappuchino: cappuchino)
        }
    }
    
    private func returnCucumbers() async -> String {
        return "Cucumbers"
    }
    
    private func returnTomatos() async -> String {
        return "Tomatos"
    }
    
    private func returnCream() async -> String {
        return "Cream"
    }
    
    
    private func buynWater() async -> String {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        print("Water")
        return "Water"
    }
    
    private func buynCoffee() async -> String {
        try? await Task.sleep(nanoseconds: 9_000_000_000)
        print("Coffe")
        return "Coffe"
    }
    
    private func buynMilk() async -> String {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        print("Milk")
        return "Milk"
    }
    
    private func makeCappuchino(water: String, coffee: String, milk: String) async -> String {
        return "Cappuchino"
    }
    
    private func makeBrave(cappuchino: String) async {
        print("Brave")
    }
}
