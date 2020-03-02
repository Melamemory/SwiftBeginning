//: A Cocoa based Playground to present user interface

import Foundation

enum EngineState {
    case stop, start
}

enum WindowState {
    case open, close
}

enum DoorState {
    case block, unblock
}

enum AirConState {
    case off, cooling, fan, heating
}

enum TrunkState {
    case empty, full // full если больше нет свободного места, иначе empty
}

enum DrivingMode {
    case racingMode, normalMode
}

enum Brand: String {
    case mersedes = "Mersedes"
    case audi = "Audi"
    case chevrolet = "Chevrolet"
    case honda = "Honda"
    
    case man = "Man"
    case belaz = "Belaz"
    case iveco = "IVECO"
    case shaanxi = "Shaanxi"
    
    case ferrari = "Ferrari"
    case porsche = "Porsche"
    case dodge = "Dodge"
    case jaguar = "Jaguar"
}

protocol Car {
    var brand: Brand { get }
    var model: String { get }
    var color: String { get set }
    var year: UInt { get }
    
    var engineState: EngineState { get set }
    var windowState: WindowState { get set }
    var doorState: DoorState { get set }
    var airConState: AirConState { get set }

    mutating func changeEngineState(_ action: EngineState)
    mutating func changeWindowState(_ action: WindowState)
    mutating func changeDoorState(_ action: DoorState)
    mutating func changeAirConState(_ action: AirConState)
}

extension Car {
    mutating func changeEngineState(_ action: EngineState) {
        self.engineState = action
    }
    mutating func changeWindowState(_ action: WindowState) {
        self.windowState = action
    }
    mutating func changeDoorState(_ action: DoorState) {
        self.doorState = action
    }
    mutating func changeAirConState(_ action: AirConState) {
        self.airConState = action
    }
}

class TrunkCar: Car {
    var brand: Brand
    var model: String
    var color: String
    var year: UInt
    
    var engineState: EngineState = .stop
    var windowState: WindowState = .close
    var doorState: DoorState = .unblock
    var airConState: AirConState = .off
        
    let maxTrunkVolume: UInt
    var currentTrunkVolume: UInt = 0
    var trunkState: TrunkState = .empty
    
    init(brand: Brand, model: String, color: String, year: UInt, maxTrunkVolume: UInt) {
        self.brand = brand
        self.model = model
        self.color = color
        self.year = year
        self.maxTrunkVolume = maxTrunkVolume
    }
    
    func addCargo(volume: UInt) {
        if (currentTrunkVolume + volume <= maxTrunkVolume) {
            currentTrunkVolume += volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == 0 {
                trunkState = .full
                print("\(brand.rawValue) \(model) became full\n")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume) \n")
            }
        } else {
            print("Cargo is too large for \(brand.rawValue) \(model) \n")
        }
    }
    
    func removeCargo(volume: UInt) {
        if (volume <= currentTrunkVolume) {
            trunkState = .empty
            currentTrunkVolume -= volume
            let freeVolume = maxTrunkVolume - currentTrunkVolume
            if freeVolume == maxTrunkVolume {
                print("\(brand.rawValue) \(model) became empty\n")
            } else {
                print("\(brand.rawValue) \(model) has free trunk space: \(freeVolume) \n")
            }
        } else {
            print("\(brand.rawValue) \(model) has not so much cargo\n")
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Truck car \(brand.rawValue) \(model) \nColor: \(color) \nMaximum weight: \(maxTrunkVolume) \n"
    }
}

class SportCar: Car {
    var brand: Brand
    var model: String
    var color: String
    var year: UInt
    
    var engineState: EngineState = .stop
    var windowState: WindowState = .close
    var doorState: DoorState = .unblock
    var airConState: AirConState = .off
    
    let time100kmph: UInt
    let maxSpeed: UInt
    var drivingMode: DrivingMode = .normalMode
    
    init(brand: Brand, model: String, color: String, year: UInt, time100kmph: UInt, maxSpeed: UInt) {
        self.brand = brand
        self.model = model
        self.color = color
        self.year = year
        self.time100kmph = time100kmph
        self.maxSpeed = maxSpeed
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Sport car \(brand.rawValue) \(model) \nColor: \(color) \nMaximum speed: \(maxSpeed) \nAcceleration from 0–100 km/h in \(time100kmph) seconds\n"
    }
}

var trunkCar1 = TrunkCar(brand: .iveco, model: "EuroCargo", color: "white", year: 2010, maxTrunkVolume: 12_000)
var trunkCar2 = TrunkCar(brand: .belaz, model: "75710", color: "yellow", year: 2014, maxTrunkVolume: 450_000)

var sportCar1 = SportCar(brand: .porsche, model: "911 GT3", color: "white", year: 2006, time100kmph: 5, maxSpeed: 305)
var sportCar2 = SportCar(brand: .ferrari, model: "Enzo", color: "red", year: 2005, time100kmph: 4, maxSpeed: 350)

trunkCar1.removeCargo(volume: 1_000)
trunkCar1.changeEngineState(.start)

trunkCar2.addCargo(volume: 300_000)
trunkCar2.addCargo(volume: 150_000)
trunkCar2.changeDoorState(.block)

sportCar1.changeAirConState(.cooling)

sportCar2.changeEngineState(.start)
sportCar2.drivingMode = .racingMode

sportCar1.changeWindowState(.open)

print(trunkCar1)
print(trunkCar2)
print(sportCar1)
print(sportCar2)
