
public class List<T> {
    var value: T!
    var next: List<T>?

//    public init() {
//        //
//    }

    public init?(_ values: T...) {
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
        print("init variants: \(values)")
        if values.count == 0 {
            return nil
        }
        value = values[0]
        print("value: \(value)")
        if values.count > 1 {
            let remaining = Array(values[1..<values.count])
            print("remaining: \(remaining)")
            next = List(slice: remaining)
        }
    }

    init!(slice: Array<T>) {
        print("init slice: \(slice)")
        if slice.count == 0 {
            return nil
        }
        value = slice[0]
        print("value: \(value)")
        if slice.count > 1 {
            let remaining = Array(slice[1..<slice.count])
            print("remaining: \(remaining)")
            next = List(slice: remaining)
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
