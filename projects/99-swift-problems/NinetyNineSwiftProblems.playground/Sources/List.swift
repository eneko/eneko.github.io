
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

}

/// Pretty print lists (literal array syntax)
extension List: CustomStringConvertible {
    public var description: String {
        var buffer: [String] = []
        var current: List? = self
        while let value = current?.value {
            buffer.append(String(value))
            current = current?.next
        }
        return "[" + buffer.joinWithSeparator(", ") + "]"
    }
}
