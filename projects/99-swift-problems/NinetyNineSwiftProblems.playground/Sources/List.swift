
class ListItem<T>: CustomStringConvertible {
    var value: T
    var next: ListItem<T>?

    init(value: T) {
        self.value = value
    }

    var description: String {
        return String(value)
    }
}

public class List<T>: CustomStringConvertible {

    var head: ListItem<T>?

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

    public var last: T? {
        guard var current = head else {
            return nil
        }
        while let next = current.next {
            current = next
        }
        return current.value
    }

    public var description: String {
        var buffer: [String] = []
        guard var current = head else {
            return "()"
        }
        buffer.append(String(current))
        while let next = current.next {
            current = next
            buffer.append(String(current))
        }
        return "(" + buffer.joinWithSeparator(", ") + ")"
    }

}
