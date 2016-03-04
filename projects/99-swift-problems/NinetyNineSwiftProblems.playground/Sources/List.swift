
import Foundation


class ListItem<T> {
    var value: T
    var next: ListItem<T>?

    init(value: T) {
        self.value = value
    }
}

public class List<T> {

    var head: ListItem<T>?

    public init() {
        //
    }

    public init(_ values: T...) {
        var current: ListItem<T>?
        for value in values {
            let newItem = ListItem<T>(value: value)
            if head == nil {
                head = newItem
            } else {
                current?.next = newItem
            }
            current = newItem
        }
    }

    public func append(value: T) {
        let newItem = ListItem<T>(value: value)
        guard var current = head else {
            head = newItem
            return
        }
        while let next = current.next {
            current = next
        }
        current.next = newItem
    }

    public func removeAll() {
        head = nil
    }

}

/// Pretty print list item values
extension ListItem: CustomStringConvertible {
    var description: String {
        return String(value)
    }
}

/// Pretty print lists (array syntax)
extension List: CustomStringConvertible {

    public var description: String {
        var buffer: [String] = []
        guard var current = head else {
            return "[]"
        }
        buffer.append(String(current))
        while let next = current.next {
            current = next
            buffer.append(String(current))
        }
        return "[" + buffer.joinWithSeparator(", ") + "]"
    }
    
}

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
    public func nth(index: Int) -> T? {
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
    public func reverseInPlace() -> List {
        let current = head
        if current == nil || current?.next == nil {
            return self
        }
        while let next = current?.next {
            current?.next = next.next
            next.next = head
            head = next
        }
        return self
    }
}

/// Problem 6
extension List where T:Equatable {
    public var isPalindrome: Bool {
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
        var current = head
        while let value = current?.value {
            switch value {
            case let list as List:
                let flattened = list.flatten()
                var currentChild = flattened.head
                while let innerValue = currentChild?.value {
                    resultList.append(innerValue)
                    currentChild = currentChild?.next
                }
            default:
                resultList.append(value)
            }
            current = current?.next
        }
        return resultList
    }
}

/// Problem 8
extension List where T: Equatable {
    public func compress() -> List {
        var current = head
        while let value = current?.value {
            if value == current?.next?.value {
                current?.next = current?.next?.next
            } else {
                current = current?.next
            }
        }
        return self
    }
}

/// Problem 9
extension List where T: Equatable {
    public func pack() -> List<List<T>> {
        let resultList = List<List<T>>()
        var current = head
        var innerList = List<T>()
        while let value = current?.value {
            innerList.append(value)
            if value != current?.next?.value {
                resultList.append(innerList)
                innerList = List<T>()
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
        var current = packed.head
        while let sublist = current?.value {
            let count = sublist.length
            let value = sublist.head!.value
            resultList.append((count, value))
            current = current?.next
        }
        return resultList
    }
}

/// Problem 11
extension List where T: Any, T: Equatable {
    public func encodeModified() -> List<Any> {
        let packed = self.pack()
        let resultList = List<Any>()
        var current = packed.head
        while let sublist = current?.value {
            let count = sublist.length
            let value = sublist.head!.value
//            if count == 1 {
//                resultList.append(value)
//            } else {
//                resultList.append((count, value))
//            }
            current = current?.next
        }
        return resultList
    }
}

