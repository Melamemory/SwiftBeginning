import Foundation

// 1. Написать функцию, которая определяет, четное число или нет.
func isEven(_ n: Int) -> Bool {
    return (n % 2 == 0)
}

// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isDividedBy3(_ n: Int) -> Bool {
    return (n % 3 == 0)
}

// 3. Создать возрастающий массив из 100 чисел.
var sortedArr: Array<Int> = []
for i in 1...100 {
    sortedArr.append(i)
}
print(sortedArr)

// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
for (_, value) in sortedArr.enumerated() {
    if isEven(value) || !isDividedBy3(value) {
        sortedArr.remove(at: sortedArr.firstIndex(of: value)!)
    }
}
print(sortedArr)

// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
func fibonacci(n: Int) -> (Decimal) {
    if (n<3) {
        return 1
    }
    var f1: Decimal = 1
    var f2: Decimal = 1
    var fn: Decimal = 1
    for _ in 3...n {
        fn = f1 + f2
        f1 = f2
        f2 = fn
    }
    return fn
}

var fibArr: Array<Decimal> = []
for i in 1...100 {
    fibArr.append(fibonacci(n: i))
}
print(fibArr)

// 6. * Заполнить массив из 100 элементов различными простыми числами.
// Вспомогательная функция, делится ли одно число на другое
func isDivided(_ n: Int, by m: Int) -> Bool {
    return (n % m == 0)
}

func primeNumbers(count: Int) -> Array<Int> {
    var arr: Array<Int> = [] // Вспомогательный массив, который просеиваем
    let length: Int = Int(1.2 * Double(count) * log(Double(count))) // Оценка: n простых чисел всречается среди первых 1.2 * n * ln(n) чисел
    arr.append(contentsOf: 2...length)
    for index in 0..<arr.count {
        guard arr[index] != 0 else {
            continue
        }
        var i = index + 1
        while i < arr.count {
            if isDivided(arr[i], by: arr[index]) {
                arr[i] = 0
            }
            i += 1
        }
    }
    var primes: Array<Int> = [] // Массив для простых чисел, который возвращаем
    var i = 0
    while primes.count < count {
        if arr[i] != 0 {
            primes.append(arr[i])
        }
        i += 1
    }
    return primes
}

var primeArr: Array<Int> = primeNumbers(count: 100)
print(primeArr)
