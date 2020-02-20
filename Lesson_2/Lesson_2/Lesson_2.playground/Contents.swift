import Foundation

var array = [1,2,3,4,5]

var string = "Hello, Swift!"
var num1 = 6.8
var num2 = 6.9

//if !array.isEmpty || num1 == num2 {
//    print("Условие истинно")
//} else if array[0] == 1 {
//    print("Array's first element is 1")
//} else if (num2 - 10) < 0 {
//    num2 *= num1
//} else if string == "Hello, Swift!" {
//    print(string)
//} else {
//    print("Условие ложно")
//}

var num3 = (num1 * num2 < 20) ? 10 : 0

// tuple
typealias CrazyType = (string: String, Int, Bool, Double, Optional<Int>, float: Float)

var tuple: CrazyType = ("String", 67, true, 123.123, Optional<Int>(nil), Float(56))

tuple.string = "New string"

//switch (num1, string) {
//case (1...10, "Hello"):
//    num1 += 1
//case (let num, "Hello, Swift!"):
//    print("Ненужное число", num)
//    fallthrough
//case (15, "String"):
//    print("Ненужное число")
//case (6.8, _):
//    print("Точное попадание")
//default:
//    print("Ни одно из значений не совпало.")
//}

//for num in array {
//    print(num)
//}
//
//for _ in 1...10 {
//    print("Repeat")
//}
//
//for (index, num) in array.enumerated() {
//    print(index, num)
//}

//for i in stride(from: 1, to: 11, by: 2) { // крайнее число не включительно, если вместо to написать through, то включительно
//    print(i)
//}

while array.count < 10 {
    array.append(array.last! * 2)
}

repeat {
    array.append(array.last! * 2)
} while array.count < 10

pow(3, 3)
sqrt(16.0)

func mult(_ x: Int, _ y: Int) -> Int {
    x * y
}

func add(_ x: Int, _ y: Int) -> Int {
    x + y
}

func creatArray(elements: Int...) -> [Int] {
    var tempArr = elements.filter({ $0 > 10 })
    
    if tempArr.count > 10 {
        var somevar = 10
        tempArr.removeAll()
    }
    //somevar = 0
    return elements
}
//tempArr
mult(12, 4)
mult(14, 3)
let t = add(3, 4)
var newArray = creatArray(elements: 1,5,3,6,73,4,3,6,4456,3,434,543,4)

// private fileprivate internal public open
