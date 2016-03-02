
class ListItem<T> {
    var value: T
    var next: ListItem<T>?

    init(value: T) {
        self.value = value
    }
}

public class List<T> {

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

}
