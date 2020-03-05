import UIKit

// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
struct Queue<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.isEmpty == false else { return nil }
        return elements.removeFirst()
    }
    
    mutating func pushAll(array: [T]) {
        for element in array {
            elements.append(element)
        }
    }
    
    func peek() -> T? {
        guard elements.isEmpty == false else { return nil }
        return elements[0]
    }
    
    func count() -> Int {
        return elements.count
    }
    
    mutating func clear() {
        elements.removeAll()
    }
    // 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
    func filter(predicate: (T) -> Bool) -> Queue<T> {
        var filteredElements = Queue()
        filteredElements.pushAll(array: elements.filter(predicate))
        return filteredElements
    }
    
    func sorted(predicate: (T, T) -> Bool) -> Queue<T> {
        var sortedQueue = Queue()
        sortedQueue.pushAll(array: elements.sorted(by: predicate))
        return sortedQueue
    }
    
    // 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    subscript(index: Int) -> T? {
        return (index >= 0 && index < elements.count) ? elements[index - 1] : nil
    }
}

func createIntQueue(array: Array<Int>) -> Queue<Int> {
    var queue = Queue<Int>()
    queue.pushAll(array: array)
    return queue
}

var array: Array<Int> = [1,2,3,4,5,6,7,8,8]

var queue = Queue<Int>()

queue.push(1)
queue.push(2)
queue.push(3)
queue.push(4)
queue.push(5)
queue.push(6)
queue.push(7)
queue.push(8)
queue.push(9)
queue.push(0)

queue.count()

queue.pop()
queue.pop()

queue.peek()


queue[-3]

var someQueue = queue.filter(predicate: { $0 % 2 == 0 })
print(someQueue)

someQueue = queue.sorted(predicate: { $0 > $1 })
print(someQueue)

someQueue.clear()
print(someQueue)

someQueue = createIntQueue(array: array)
print(someQueue)

someQueue[3]
