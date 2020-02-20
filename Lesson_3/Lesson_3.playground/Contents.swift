//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport
import Foundation

enum EngineState {
    case start
    case stop
}

enum Brand: String {
    case bmw = "BMW"
    case mersedes = "Mersedes-Benz"
    case audi = "Audi"
    case vw = "VolksWagen"
    
    var name: String {
        return "Имя бренда: \(rawValue)"
    }
    
    func calculatePriority() -> String {
        return "Priority of Brand"
    }
}

enum CarState {
    case new
    case secondHand(mileage: Double)
}

struct Car {
    var brand: Brand
    var model: String
    var color: String
    var mileage: CarState
    
    var price: Int
    private(set) var currentDiscount: Int = 0
    var discount: Int {
        get {
            return currentDiscount
        }
        set {
            if currentDiscount != 0 {
                price = price / (100 - currentDiscount) * 100
            }
            currentDiscount = newValue
            price -= (price * newValue / 100)
        }
    }
    
    private(set) var engineState: EngineState = .stop {
        willSet {
            print("Значение будет изменено с \(engineState) на \(newValue)")
        }
        didSet {
            print("Состояние двигателя поменялось с \(oldValue) на \(engineState)")
        }
    }
    
    init(brand: Brand, model: String, color: String, mileage: CarState = .new, price: Int) {
        self.brand = brand
        self.model = model
        self.color = color
        self.mileage = mileage
        self.price = price
        self.currentDiscount = 0
    }
    
    init?(brand: Brand) {
        guard brand == .bmw else { return nil }
        self.brand = .bmw
        self.model = "X7"
        self.color = "White"
        self.mileage = .new
        self.price = 7_900_000
        
    }
    
    mutating func changeEngineState() {
        if engineState == .stop {
            self.engineState = .start
        } else {
            self.engineState = .stop
        }
    }
}

var brand1 = Brand.mersedes
brand1.name
brand1.calculatePriority()

var state = CarState.secondHand(mileage: 15_000)

switch state {
case .new:
    print("Автомобиль из салона")
case .secondHand(let mileage):
    print("Автомобиль с пробегом: \(mileage) km")
}

var car = Car(brand: .bmw, model: "X5", color: "Black", mileage: .secondHand(mileage: 100_000), price: 1_000_000)
var newCar = Car(brand: .mersedes, model: "G63", color: "Grey", mileage: .secondHand(mileage: 100_000), price: 1_000_000)
var newBmw = Car(brand: .bmw)

if let car = newBmw {
    print(car)
}


car.discount = 10
print(car.price)
car.discount = 0
print(car.price)
car.changeEngineState()
