//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

enum BrandPasCar: String {
    case mercedes = "Mercedes"
    case audi = "Audi"
    case chevrolet = "Chevrolet"
    case honda = "Honda"
    case tesla = "Tesla"
    case toyota = "Toyota"
}

enum BrandTruck: String {
    case kamaz = "КамАЗ"
    case man = "MAN"
    case iveco = "IVECO"
    case mercedes = "Mercedes"
    case foton = "Foton"
    case shaanxi = "Shaanxi"
}

enum EngineState {
    case stop, start
}

enum WindowState {
    case open, close
}

enum DoorState {
    case block, unblock
}

enum TrunkState {
    case empty, full // full если больше нет свободного места, иначе empty
}

enum AirConditionerState: String {
    case off
    case cooling
    case fan
    case heating
}

struct PassengerCar {
    let brand: BrandPasCar
    let model: String
    var color: String
    let year: UInt
    var engineState: EngineState = .stop
    var windowState: WindowState = .close
    var doorState: DoorState = .unblock
    private(set) var airCondState: AirConditionerState = .off
    private(set) var trunkState: TrunkState
    let maxTrunkVolume: UInt
    private(set) var currentTrunkVolume: UInt
    
    mutating func addCargo(volume: UInt) {
        if (currentTrunkVolume + volume <= maxTrunkVolume) {
            currentTrunkVolume += volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == 0 {
                trunkState = .full
                print("\(brand.rawValue) \(model) become full")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume)")
            }
        } else {
            print("Cargo is too large for \(brand.rawValue) \(model)")
        }
    }
    
    mutating func removeCargo(volume: UInt) {
        if volume <= currentTrunkVolume {
            trunkState = .empty
            currentTrunkVolume -= volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == maxTrunkVolume {
                print("\(brand.rawValue) \(model) become empty")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume)")
            }
        } else {
            print("\(brand.rawValue) \(model) has not so much cargo")
        }
    }
    
    mutating func changeAirCondState(newState: AirConditionerState) {
        if newState == .off {
            airCondState = .off
            print("In \(brand.rawValue) \(model) A/C is off")
        } else if airCondState == newState {
            print("In \(brand.rawValue) \(model) \(airCondState) is already on")
        } else {
            airCondState = newState
            print("In \(brand.rawValue) \(model) \(airCondState) is on")
        }
    }
    
    mutating func closeCar() {
        engineState = .stop
        windowState = .close
        changeAirCondState(newState: .off)
        doorState = .block
        print("\(brand.rawValue) \(model) is closed")
    }
}

struct Truck {
    let brand: BrandTruck
    let model: String
    var color: String
    let year: UInt
    var engineState: EngineState = .stop
    var windowState: WindowState = .close
    var doorState: DoorState = .unblock
    private(set) var airCondState: AirConditionerState = .off
    private(set) var trunkState: TrunkState
    let maxTrunkVolume: UInt
    private(set) var currentTrunkVolume: UInt
    
    mutating func addCargo(volume: UInt) {
        if (currentTrunkVolume + volume <= maxTrunkVolume) {
            currentTrunkVolume += volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == 0 {
                trunkState = .full
                print("\(brand.rawValue) \(model) become full")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume)")
            }
        } else {
            print("Cargo is too large for \(brand.rawValue) \(model)")
        }
    }
    
    mutating func removeCargo(volume: UInt) {
        if volume <= currentTrunkVolume {
            trunkState = .empty
            currentTrunkVolume -= volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == maxTrunkVolume {
                print("\(brand.rawValue) \(model) become empty")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume)")
            }
        } else {
            print("\(brand.rawValue) \(model) has not so much cargo")
        }
    }
    
    mutating func closeCar() {
        engineState = .stop
        windowState = .close
        doorState = .block
        print("\(brand.rawValue) \(model) is closed")
    }
}

var truck1 = Truck(brand: .kamaz, model: "4308", color: "orange", year: 2008, engineState: .stop, windowState: .close, trunkState: .empty, maxTrunkVolume: 10_000, currentTrunkVolume: 5_000)

var car1 = PassengerCar(brand: .audi, model: "TT", color: "red", year: 2016, engineState: .stop, windowState: .close, doorState: .block, airCondState: .off, trunkState: .empty, maxTrunkVolume: 1_500, currentTrunkVolume: 1_000)

var car2 = PassengerCar(brand: .chevrolet, model: "Kamaro", color: "yellow", year: 2010, engineState: .stop, windowState: .close, doorState: .unblock, airCondState: .off, trunkState: .empty, maxTrunkVolume: 1_200, currentTrunkVolume: 1_000)

truck1.windowState = .open
truck1.engineState = .start
print(truck1)
truck1.addCargo(volume: 6_000)
truck1.addCargo(volume: 5_000)
truck1.removeCargo(volume: 9_000)
truck1.removeCargo(volume: 100)
truck1.closeCar()

car1.doorState = .unblock
car1.addCargo(volume: 100)
print(car1.currentTrunkVolume)
car1.removeCargo(volume: 1_100)
car1.changeAirCondState(newState: .cooling)
car1.changeAirCondState(newState: .heating)
car1.closeCar()

car2.windowState = .open
car2.engineState = .start
car2.addCargo(volume: 200)
car2.removeCargo(volume: 500)
car2.addCargo(volume: 600)
car2.changeAirCondState(newState: .heating)
car2.changeAirCondState(newState: .heating)
car2.closeCar()
print(car2.color)
