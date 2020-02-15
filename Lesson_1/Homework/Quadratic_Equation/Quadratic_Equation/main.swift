//
//  main.swift
//  1l_ИшмурзинаЮлия
//
//  Created by Юлия Ишмурзина on 13.02.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

func main() {
    let coef: Array<Double> = readDoubles()

    let roots = solveQuadraticEquation(coef: coef)
    switch roots.count {
    case 2:
        print("Уравнение имеет два различных корня\nx1 = \(roots[0])\nx2 = \(roots[1])")
    case 1:
        print("Уравнение имеет один корень двойной кратности\nx0 = \(roots[0])")
    default:
        print("Уравнение не имеет решений")
    }
}

func solveQuadraticEquation (coef: Array<Double>) -> Array<Double> {
    let d = coef[1] * coef[1] - 4 * coef[0] * coef[2]
    switch d {
    case 0 :
        return [(-coef[1]) / (2 * coef[0])]
    case let positiveDiscr where positiveDiscr > 0 :
        let sqrtDiskr = d.squareRoot()
        return [(-coef[1] + sqrtDiskr) / (2 * coef[0]),
                (-coef[1] - sqrtDiskr) / (2 * coef[0])]
    default :
        return []
    }
}

func readDoubles () -> Array<Double> {
    var numbers: Array<Double> = []
    let expectedNumberCount: Int = 3
    while true {
        print("Введите коэффициенты квадратного уравнения, разделяя их пробелом")
        numbers = []
        let str = readLine()
        let strParts = str?.split(separator: " ")
        if let arr = strParts {
            if (arr.count != expectedNumberCount) {
                print("Введены некорректные значения!")
                continue
            }
            for i in 0..<expectedNumberCount {
                if Double(arr[i]) != nil {
                    numbers.append(Double(arr[i])!)
                } else {
                    break
                }
            }
            if numbers.count != expectedNumberCount {
                print("Введены некорректные значения!")
                continue
            }
            if numbers[0] == 0 {
                print("Старший коэффициент не должен быть равен 0!")
                continue
            }
            return numbers
        }
    }
}

main()
