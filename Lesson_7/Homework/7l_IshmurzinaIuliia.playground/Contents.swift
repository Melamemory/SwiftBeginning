import Foundation

// 1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.

enum QuadraticEquationError: Error {
    case notQuadraticEquation
    case negativeDiscriminant
}

class QuadraticEquation {
    
    private let a: Double
    private let b: Double
    private let c: Double
    
    init(a: Double, b: Double, c: Double) {
        self.a = a
        self.b = b
        self.c = c
    }
    
    func solve() throws -> (x1: Double, x2: Double) {
        guard a != 0 else { throw QuadraticEquationError.notQuadraticEquation }
        let d = b * b - 4.0 * a * c
        guard d >= 0 else { throw QuadraticEquationError.negativeDiscriminant }
        let x1 = (-b - sqrt(d)) / (2 * a)
        let x2 = (-b + sqrt(d)) / (2 * a)
        return (x1, x2)
    }
}

let quadEq1 = QuadraticEquation(a: -1, b: 2, c: 3)
let quadEq2 = QuadraticEquation(a: 0, b: 2, c: 3)
let quadEq3 = QuadraticEquation(a: 1, b: 2, c: 3)
let quadEq4 = QuadraticEquation(a: 1, b: 2, c: 1)

do {
    print(try quadEq1.solve())
} catch QuadraticEquationError.notQuadraticEquation {
    print("Старший коэффициент уравнения равен нулю")
} catch QuadraticEquationError.negativeDiscriminant {
    print("Квадратное уравнение не имеет решений")
}

do {
    print(try quadEq2.solve())
} catch QuadraticEquationError.notQuadraticEquation {
    print("Старший коэффициент уравнения равен нулю")
} catch QuadraticEquationError.negativeDiscriminant {
    print("Квадратное уравнение не имеет решений")
}

do {
    print(try quadEq3.solve())
} catch QuadraticEquationError.notQuadraticEquation {
    print("Старший коэффициент уравнения равен нулю")
} catch QuadraticEquationError.negativeDiscriminant {
    print("Квадратное уравнение не имеет решений")
}

do {
    print(try quadEq4.solve())
} catch QuadraticEquationError.notQuadraticEquation {
    print("Старший коэффициент уравнения равен нулю")
} catch QuadraticEquationError.negativeDiscriminant {
    print("Квадратное уравнение не имеет решений")
}

print("\n")

// 2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

enum ATMError: Error {
    case incorrectSum  // Сумма должна быть кратна 100 и положительна
    case notEnoughMoney // В банкомате недостаточно средств
    case notEnoughBanknotes // Запрошенная сумма не может быть выдана имеющимися купюрами
}

struct Banknote: CustomStringConvertible {
    let faceValue: Int
    var count: Int
    var description: String {
        return "\(faceValue): \(count)"
    }
}

class ATM {
    
    private(set) var banknotes: Array<Banknote> = [
    Banknote(faceValue: 5000, count: 5),
    Banknote(faceValue: 2000, count: 5),
    Banknote(faceValue: 1000, count: 10),
    Banknote(faceValue: 500, count: 10),
    Banknote(faceValue: 200, count: 1),
    Banknote(faceValue: 100, count: 20),
    ]
    
    private var totalAmount: Int {
        var sum = 0
        for banknote in banknotes {
            sum += banknote.faceValue * banknote.count
        }
        return sum
    }
    
    func dispenseCash(requestedAmount: Int) throws -> Array<Banknote> {
        guard requestedAmount % 100 == 0 && requestedAmount > 0 else { throw ATMError.incorrectSum }
        guard requestedAmount <= totalAmount else { throw ATMError.notEnoughMoney }
        var inSum = requestedAmount
        var arrBank: Array<Banknote> = []
        for i in 0..<banknotes.count {
            arrBank.append(Banknote(faceValue: banknotes[i].faceValue, count: 0))
            while inSum >= banknotes[i].faceValue && banknotes[i].count > 0 {
                inSum -= banknotes[i].faceValue
                banknotes[i].count -= 1
                arrBank[i].count += 1
            }
        }
        guard inSum == 0 else {
            for i in 0..<arrBank.count {
                banknotes[i].count += arrBank[i].count
            }
            throw ATMError.notEnoughBanknotes
        }
        arrBank.removeAll(where: { $0.count == 0 })
        return arrBank
    }
}

let sberbank = ATM()

print(try sberbank.dispenseCash(requestedAmount: 900))
