
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

// Append simplifies some methods but leads to N*lgN or N^2 in some cases
//    public func append(value: T) {
//        let newItem = ListItem<T>(value: value)
//        guard var current = head else {
//            head = newItem
//            return
//        }
//        while let next = current.next {
//            current = next
//        }
//        current.next = newItem
//    }

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
