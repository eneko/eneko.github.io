
extension Tree {
    public class func cBalanced(number: Int, _ value: T) -> List<Tree<T>> {
        return List(Tree(value))!
    }
}

extension Tree where T: Comparable {
    public func addValue(value: T) -> Tree {
        if value >= self.value {
            if let r = right {
                r.addValue(value)
            } else {
                right = Tree(value)
            }
        } else {
            if let l = left {
                l.addValue(value)
            } else {
                left = Tree(value)
            }
        }
        return self
    }
}

extension Tree where T: Comparable {
    public class func fromList(list: List<T>) -> Tree {
        let tree = Tree(list.value)
        var current = list
        while let next = current.next {
            tree.addValue(next.value)
            current = next
        }
        return tree
    }
}
