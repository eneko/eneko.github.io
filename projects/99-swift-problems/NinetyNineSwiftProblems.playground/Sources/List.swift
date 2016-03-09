
public class List<T> {
    var value: T
    var next: List<T>?

//    public init() {
//        //
//    }

    public init(_ values: T...) {
//        var current: ListItem<T>?
//        for value in values {
//            let newItem = ListItem<T>(value: value)
//            if head == nil {
//                head = newItem
//            } else {
//                current?.next = newItem
//            }
//            current = newItem
//        }
        value = values[0]
        if values.count > 1 {
            next = List(values[1..<values.count])
        }
    }

    init(_ values: ArraySlice<T>) {
        value = values[0]
        if values.count > 1 {
            next = List(values[1..<values.count])
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

/// Pretty print lists (array syntax)
extension List: CustomStringConvertible {
    public var description: String {
        var buffer: [String] = []
        var current = self
        buffer.append(String(current.value))
        while let next = current.next {
            current = next
            buffer.append(String(current.value))
        }
        return "[" + buffer.joinWithSeparator(", ") + "]"
    }
}
