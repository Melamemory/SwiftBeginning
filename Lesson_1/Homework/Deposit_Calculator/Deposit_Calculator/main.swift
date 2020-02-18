//
//  main.swift
//  Deposit_Calculator
//
//  Created by Юлия Ишмурзина on 15.02.2020.
//  Copyright © 2020 Юлия Ишмурзина. All rights reserved.
//

func main() {
    let depositInformation: Array<Double> = readDoubles()
    let maxYears: Int = 5
    print("Через \(maxYears) лет сумма вклада будет \(depositSum(deposit: depositInformation, maxYears:  maxYears)) ")
}

func depositSum(deposit: Array<Double>, maxYears: Int) -> Double {
    var sum = deposit[0]
    let percent = deposit[1] / 100 + 1
    for _ in 1...maxYears {
        sum = sum * percent
        //print(sum)
    }
    return sum
}

func readDoubles () -> Array<Double> {
    var numbers: Array<Double> = []
    let expectedNumberCount: Int = 2
    while true {
        print("Введите сумму вклада и годовой процент, разделяя их пробелом")
        numbers = []
        let str = readLine()
        let strParts = str?.split(separator: " ")
        if let arr = strParts {
            var errorCount = false
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
                        errorCount = true
                        break
                    }
                } else {
                    break
                }
            }
            if errorCount {
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
