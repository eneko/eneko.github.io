
public class List<T> {
    var value: T!
    var next: List<T>?

    public convenience init!(_ values: T...) {
        self.init(Array(values))
    }

    init!(var _ values: Array<T>) {
        if values.count == 0 {
            return nil
        }
        value = values.removeFirst()
        next = List(values)
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
