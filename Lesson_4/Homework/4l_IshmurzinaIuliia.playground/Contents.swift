import Foundation

enum Action {
    case start, stop
    case open, close
    case block, unblock
    case off, cooling, fan, heating
    case empty, full
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

class Car {
    let brand: Brand
    let model: String
    let color: String
    let year: UInt
    var engineState: Action = .stop
    var windowState: Action = .close
    var doorState: Action = .unblock
    var airConState: Action = .off
    
    init(brand: Brand, model: String, color: String, year: UInt) {
        self.brand = brand
        self.model = model
        self.color = color
        self.year = year
    }
    
    func changeSomeState(_ action: Action) {
        
    }
}

class TrunkCar: Car {
    let maxTrunkVolume: UInt
    var currentTrunkVolume: UInt = 0
    var trunkState: Action = .empty
    
    init(brand: Brand, model: String, color: String, year: UInt, maxTrunkVolume: UInt) {
        self.maxTrunkVolume = maxTrunkVolume
        super.init(brand: brand, model: model, color: color, year: year)
    }
    
    override func changeSomeState(_ action: Action) {
        switch action {
        case .start, .stop:
            self.engineState = action
        case .open, .close:
            self.windowState = action
        case .block, .unblock:
            self.doorState = action
        case .off, .cooling, .fan, .heating:
            self.airConState = action
        case .empty, .full:
            self.trunkState = action
        default:
            print("This car hasn't this mode")
        }
    }
    
    func addCargo(volume: UInt) {
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
    
    func removeCargo(volume: UInt) {
        if (volume <= currentTrunkVolume) {
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
}

class SportCar: Car {
    let time100kmph: UInt
    let maxSpeed: UInt
    var drivingMode: Action = .normalMode
    
    init(brand: Brand, model: String, color: String, year: UInt, time100kmph: UInt, maxSpeed: UInt) {
        self.time100kmph = time100kmph
        self.maxSpeed = maxSpeed
        super.init(brand: brand, model: model, color: color, year: year)
    }
    
    override func changeSomeState(_ action: Action) {
        switch action {
        case .start, .stop:
            self.engineState = action
        case .open, .close:
            self.windowState = action
        case .block, .unblock:
            self.doorState = action
        case .off, .cooling, .fan, .heating:
            self.airConState = action
        case .racingMode, .normalMode:
            self.drivingMode = action
        default:
            print("This car hasn't this mode")
        }
    }
}

var car = Car(brand: .audi, model: "TT", color: "black", year: 2015)

var trunkCar1 = TrunkCar(brand: .iveco, model: "EuroCargo", color: "white", year: 2010, maxTrunkVolume: 12_000)
var trunkCar2 = TrunkCar(brand: .belaz, model: "75710", color: "yellow", year: 2014, maxTrunkVolume: 450_000)

var sportCar1 = SportCar(brand: .porsche, model: "911 GT3", color: "white", year: 2006, time100kmph: 4, maxSpeed: 305)
var sportCar2 = SportCar(brand: .ferrari, model: "Enzo", color: "red", year: 2005, time100kmph: 4, maxSpeed: 350)

car.changeSomeState(.block) // Car's method is empty
print(car.doorState)

trunkCar1.changeSomeState(.full)
print(trunkCar1.trunkState)

trunkCar2.addCargo(volume: 300_000)
trunkCar2.changeSomeState(.racingMode)

sportCar1.changeSomeState(.racingMode)
print(sportCar1.drivingMode)

sportCar2.changeSomeState(.open)
print(sportCar2.windowState)

sportCar1.changeSomeState(.empty)
