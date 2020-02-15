//
//  main.swift
//  Right_Triangle
//
//  Created by Юлия Ишмурзина on 15.02.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

func main() {
    let cathets: Array<Double> = readDoubles()
    let solves = solveRightTriangle(cathets: cathets)
    print("Гипотенуза\n\(solves.hypotenuse)")
    print("Площадь треугольника\n\(solves.square)")
    print("Периметр треугольника\n\(solves.perimeter)")
}

func solveRightTriangle(cathets: Array<Double>) -> (hypotenuse: Double, square: Double, perimeter: Double) {
    let hypotenuse = (cathets[0] * cathets[0] + cathets[1] * cathets[1]).squareRoot()
    let square = 0.5 * cathets[0] * cathets[1]
    let perimeter = cathets[0] + cathets[1] + hypotenuse
    return (hypotenuse, square, perimeter)
}

func readDoubles () -> Array<Double> {
    var numbers: Array<Double> = []
    let expectedNumberCount: Int = 2
    while true {
        print("Введите длины катетов прямоугольного треугольника, разделяя их пробелом")
        numbers = []
        let str = readLine()
        let strParts = str?.split(separator: " ")
        if let arr = strParts {
            var errorCount = 0
            if (arr.count != expectedNumberCount) {
                print("Введены некорректные значения!")
                continue
            }
            for i in 0..<expectedNumberCount {
                if Double(arr[i]) != nil {
                    if Double(arr[i])! > 0 {
                        numbers.append(Double(arr[i])!)
                    } else {
                        print("Числа должны быть положительными!")
                        errorCount += 1
                        break
                    }
                } else {
                    break
                }
            }
            if errorCount > 0 {
                continue
            }
            if numbers.count != expectedNumberCount {
                print("Введены некорректные значения!")
                continue
            }
            return numbers
        }
    }
}

main()
