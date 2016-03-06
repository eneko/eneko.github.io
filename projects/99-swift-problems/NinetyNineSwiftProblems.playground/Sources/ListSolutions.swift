import Foundation

/// Problem 1
extension List {
    public var last: T? {
        guard var current = head else {
            return nil
        }
        while let next = current.next {
            current = next
        }
        return current.value
    }
}

/// Problem 2
extension List {
    public var pennultimate: T? {
        var current = head
        while current?.next != nil {
            if current?.next?.next == nil {
                return current?.value
            }
            current = current?.next
        }
        return nil
    }
}

/// Problem 3
extension List {
    public func elementAtIndex(index: Int) -> T? {
        var count = 0
        var current = head
        while count < index {
            count++
            current = current?.next
            if current == nil {
                break
            }
        }
        return current?.value
    }
}

/// Problem 4
extension List {
    public var length: Int {
        var count = 0
        var current = head
        while current != nil {
            count++
            current = current?.next
        }
        return count
    }
}

/// Problem 5
extension List {
    public func reverseInPlace() {
        let current = head
        if current == nil || current?.next == nil {
            return
        }
        while let next = current?.next {
            current?.next = next.next
            next.next = head
            head = next
        }
    }
}

/// Problem 6
extension List where T:Equatable {
    public func isPalindrome() -> Bool {
        var stack: [T] = []
        var current = head
        while current != nil {
            stack.append(current!.value)
            current = current?.next
        }
        current = head
        while current != nil {
            if current?.value != stack.removeLast() {
                return false
            }
            current = current?.next
        }
        return stack.count == 0
    }
}

/// Problem 7
extension List {
    public func flatten() -> List {
        let resultList = List()
        var resultListLast = resultList.head
        var current = head
        while let value = current?.value {
            switch value {
            case let list as List:
                let flattened = list.flatten()
                var currentChild = flattened.head
                while let innerValue = currentChild?.value {
                    let newItem = ListItem(value: innerValue)
                    if resultListLast == nil {
                        resultList.head = newItem
                    } else {
                        resultListLast?.next = newItem
                    }
                    resultListLast = newItem
                    currentChild = currentChild?.next
                }
            default:
                let newItem = ListItem(value: value)
                if resultListLast == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            current = current?.next
        }
        return resultList
    }
}

/// Problem 8
extension List where T: Equatable {
    public func compressInPlace() {
        var current = head
        while let value = current?.value {
            if value == current?.next?.value {
                current?.next = current?.next?.next
            } else {
                current = current?.next
            }
        }
    }
}

/// Problem 9
extension List where T: Equatable {
    public func pack() -> List<List<T>> {
        let resultList = List<List<T>>()
        var resultListLast = resultList.head
        var current = head
        var innerList = List<T>()
        var innerListLast = innerList.head
        while let value = current?.value {
            let newItem = ListItem(value: value)
            if innerList.head == nil {
                innerList.head = newItem
            } else {
                innerListLast?.next = newItem
            }
            innerListLast = newItem
            if value != current?.next?.value {
                let newResultItem = ListItem(value: innerList)
                if resultList.head == nil {
                    resultList.head = newResultItem
                } else {
                    resultListLast?.next = newResultItem
                }
                resultListLast = newResultItem
                innerList = List<T>()
                innerListLast = innerList.head
            }
            current = current?.next
        }
        return resultList
    }
}

/// Problem 10
extension List where T: Equatable {
    public func encode() -> List<(Int, T)> {
        let packed = self.pack()
        let resultList = List<(Int, T)>()
        var resultListLast = resultList.head
        var current = packed.head
        while let sublist = current?.value {
            let count = sublist.length
            let value = sublist.head!.value
            let newItem = ListItem(value: (count, value))
            if resultList.head == nil {
                resultList.head = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
            current = current?.next
        }
        return resultList
    }
}

/// Problem 11
extension List where T: Equatable {
    public func encodeModified() -> List<Any> {
        let packed = self.pack()
        let resultList = List<Any>()
        var resultListLast = resultList.head
        var current = packed.head
        while let sublist = current?.value {
            let count = sublist.length
            let value = sublist.head!.value
            var newItem: ListItem<Any>
            if count == 1 {
                newItem = ListItem(value: value)
            } else {
                let pack = List<Any>(count, value)
                newItem = ListItem(value: pack)
            }
            if resultList.head == nil {
                resultList.head = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
            current = current?.next
        }
        return resultList
    }
}

/// Problem 12
extension List {
    public func decode() -> List<String> {
        let resultList = List<String>()
        var resultListLast = resultList.head
        var current = head
        while let value = current?.value as? (Int, String) {
            for _ in 1...value.0 {
                let newItem = ListItem(value: value.1)
                if resultList.head == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            current = current?.next
        }
        return resultList
    }
}

/// Problem 13
extension List where T: Equatable {
    public func encodeDirect() -> List<(Int, T)> {
        let resultList = List<(Int, T)>()
        var resultListLast = resultList.head
        var current = head
        var count = 1
        while let value = current?.value {
            if value == current?.next?.value {
                count++
            } else {
                let newItem = ListItem(value: (count, value))
                if resultList.head == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
                count = 1
            }
            current = current?.next
        }
        return resultList
    }
}

/// Problem 14
extension List {
    public func duplicateInPlace() -> List {
        var current = head
        while let value = current?.value {
            let dupe = ListItem(value: value)
            dupe.next = current?.next
            current?.next = dupe
            current = dupe.next
        }
        return self
    }
}

/// Problem 15
extension List {
    public func duplicateInPlace(times: Int) -> List {
        var current = head
        while let value = current?.value {
            for _ in 1..<times {
                let dupe = ListItem(value: value)
                dupe.next = current?.next
                current?.next = dupe
                current = dupe
            }
            current = current?.next
        }
        return self
    }
}

/// Problem 16
extension List {
    public func drop(every: Int) -> List {
        let resultList = List()
        var resultListLast = resultList.head
        var current = head
        var index = 1
        while let value = current?.value {
            if index % every != 0 {
                let newItem = ListItem(value: value)
                if resultList.head == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return resultList
    }
}

/// Problem 17
extension List {
    public func split(atIndex: Int) -> (List, List) {
        let left = List()
        var leftLast = left.head
        let right = List()
        var rightLast = right.head
        var index = 0
        var current = head
        while let value = current?.value {
            let newItem = ListItem(value: value)
            if index < atIndex {
                if left.head == nil {
                    left.head = newItem
                } else {
                    leftLast?.next = newItem
                }
                leftLast = newItem
            } else {
                if right.head == nil {
                    right.head = newItem
                } else {
                    rightLast?.next = newItem
                }
                rightLast = newItem
            }
            index++
            current = current?.next
        }
        return (left, right)
    }
}

/// Problem 18
extension List {
    public func slice(from: Int, _ to: Int) -> List {
        let resultList = List()
        var resultListLast = resultList.head
        var current = head
        var index = 0
        while let value = current?.value {
            if index >= from && index < to {
                let newItem = ListItem(value: value)
                if resultList.head == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return resultList
    }
}

/// Problem 19
/// TODO: Can we do negative rotation without knowing the length of the list?
/// being lazy, let's use split and concatenate
extension List {
    public func rotate(amount: Int) -> List {
        // Split list in two pieces
        let listLength = self.length
        let splitIndex = listLength > 0 ? (listLength + amount) % listLength : 0
        let parts = split(splitIndex)

        // Start with second piece
        let resultList = parts.1
        var current = resultList.head
        while current?.next != nil {
            current = current?.next
        }
        var resultListLast = current

        // Append first piece
        current = parts.0.head
        while let value = current?.value {
            let newItem = ListItem(value: value)
            if resultList.head == nil {
                resultList.head = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
            current = current?.next
        }
        return resultList
    }
}

/// Problem 20
extension List {
    public func removeAt(position: Int) -> (List, T?) {
        let resultList = List()
        var resultListLast = resultList.head
        var current = head
        var index = 0
        var item: T?
        while let value = current?.value {
            if index == position {
                item = value
            } else {
                let newItem = ListItem(value: value)
                if resultList.head == nil {
                    resultList.head = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return (resultList, item)
    }
}

/// Problem 21
extension List {
    public func insertAt(index: Int, _ value: T) {
        var current = head
        var currentIndex = 1
        while current != nil {
            if currentIndex == index {
                let newItem = ListItem(value: value)
                newItem.next = current?.next
                current?.next = newItem
                break
            }
            currentIndex++
            current = current?.next
        }
    }
}

/// Problem 22
extension List {
    public class func range(from: Int, _ to: Int) -> List<Int> {
        let resultList = List<Int>()
        var resultListLast = resultList.head
        for i in from...to {
            let newItem = ListItem<Int>(value: i)
            if resultList.head == nil {
                resultList.head = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
        }
        return resultList
    }
}

/// Problem 23
extension List {
    public func randomSelect(amount: Int) -> List {
        let resultList = List()
        var resultListLast = resultList.head
        var count = 0
        var list = self
        while count < amount {
            let length = list.length
            let index = Int(arc4random_uniform(UInt32(length)))
            let result = list.removeAt(index)
            list = result.0
            guard let value = result.1 else {
                break
            }
            let newItem = ListItem(value: value)
            if resultList.head == nil {
                resultList.head = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
            count++
        }
        return resultList
    }
}

/// Problem 24
extension List {
    public class func lotto(numbers: Int, _ maximum: Int) -> List<Int> {
        let numberList = List<Int>.range(1, maximum)
        return numberList.randomSelect(numbers)
    }
}

/// Problem 25
extension List {
    public func randomPermute() -> List {
        return randomSelect(length)
    }
}

/// Problem 26
/// This is pretty hardcore with a linked list
extension List {
    public func combinations(group: Int) -> List<List<T>> {
        let resultList = List<List<T>>()
        var resultListLast = resultList.head
        if group > 1 {
            let itemCount = length
            var current = head
            var index = 0
            while let value = current?.value {
                let theOthers = self.removeAt(index).0
                let theirCombinations = theOthers.combinations(group-1)
                var innerCurrent = theirCombinations.head
                while let innerList = innerCurrent?.value {
                    let myCombinations = List(value)
                    var myCombinationsLast = myCombinations.head
                    var currentItem = innerList.head
                    while let innerValue = currentItem?.value {
                        let newCombinationItem = ListItem(value: innerValue)
                        myCombinationsLast?.next = newCombinationItem
                        myCombinationsLast = newCombinationItem
                        currentItem = currentItem?.next
                    }
                    let newItem = ListItem(value: myCombinations)
                    if resultList.head == nil {
                        resultList.head = newItem
                    } else {
                        resultListLast?.next = newItem
                    }
                    resultListLast = newItem
                    innerCurrent = innerCurrent?.next
                }
                index++
                current = current?.next
            }
        } else {
            // N groups of 1 item
            var current = head
            while let value = current?.value {
                let newList = ListItem(value: List(value))
                if resultList.head == nil {
                    resultList.head = newList
                } else {
                    resultListLast?.next = newList
                }
                resultListLast = newList
                current = current?.next
            }
        }
        return resultList
    }
}
