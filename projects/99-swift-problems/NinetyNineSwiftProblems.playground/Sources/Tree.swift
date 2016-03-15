
public class Tree<T> {
    let value: T
    var left: Tree<T>?
    var right: Tree<T>?

    public init(_ value: T, _ left: Tree<T>? = nil, _ right: Tree<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension Tree: CustomStringConvertible {
    public var description: String {
        if left != nil && right != nil {
            return "T(\(value) \(left!) \(right!))"
        } else if left != nil {
            return "T(\(value) \(left!) nil)"
        } else if right != nil {
            return "T(\(value) nil \(right!))"
        } else {
            return "T(\(value) nil nil)"
        }
    }
}
