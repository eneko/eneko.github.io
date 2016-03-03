
class ListItem<T> {
    var value: T
    var next: ListItem<T>?

    init(value: T) {
        self.value = value
    }
}

extension ListItem: CustomStringConvertible {
    var description: String {
        return String(value)
    }
}

protocol Listable {
    typealias A
    func flatten() -> A
}

public class List<T>: Listable {

    var head: ListItem<T>?

    public init() {
        //
    }

    public init(_ values: T...) {
        for value in values {
            append(value)
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

    /// Problem 1
    public var last: T? {
        guard var current = head else {
            return nil
        }
        while let next = current.next {
            current = next
        }
        return current.value
    }

    /// Problem 2
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

    /// Problem 3
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

    /// Problem 4
    public var length: Int {
        var count = 0
        var current = head
        while current != nil {
            count++
            current = current?.next
        }
        return count
    }

    /// Problem 5
    public func reverseInPlace() -> List<T> {
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

    /// Problem 7
    public func flatten() -> List<T> {
        print("Start -----------------")
        print("List: \(self)")
        let resultList = List<T>()
        print("resultList: \(resultList)")
        var current = head
        while let value = current?.value {
            print("value: \(value), \(value.dynamicType)")
            switch value {
            case let list as Listable:
                print("value is listable!")
                let flattened = list.flatten()
                print("flattened: \(flattened)")
                var currentChild = flattened.head
                while let innerValue = currentChild?.value {
                    print("innervalue: \(innerValue)")
                    resultList.append(innerValue)
                    print("resultList: \(resultList)")
                    currentChild = currentChild?.next
                }
            default:
                resultList.append(value)
            }
//            if value is Listable {
//                let flattened = (value as! Listable).flatten()
//                print("flattened: \(flattened)")
//                var currentChild = flattened.head
//                while let innerValue = currentChild?.value {
//                    print("innervalue: \(innerValue)")
//                    resultList.append(innerValue)
//                    print("resultList: \(resultList)")
//                    currentChild = currentChild?.next
//                }
//            } else {
//                //resultList.append(value)
//            }
            print("resultList: \(resultList)")
            current = current?.next
        }
        return resultList
    }

}

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

extension List where T:Equatable {

    /// Problem 6
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
