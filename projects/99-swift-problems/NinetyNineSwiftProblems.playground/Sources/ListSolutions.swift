import Foundation

extension List {
    /// P01 (*) Find the last element of a linked list.
    /// - complexity: O(n)
    public var last: T {
        var current = self
        while let next = current.next {
            current = next
        }
        return current.value
    }
}

extension List {
    /// P02 (*) Find the last but one element of a linked list.
    /// - complexity: O(n)
    public var pennultimate: T? {
        var current = self
        while let next = current.next {
            if next.next == nil {
                return current.value
            }
            current = next
        }
        return nil
    }
}

extension List {
    /// P03 (*) Find the Kth element of a linked list.
    /// - complexity: O(n)
    public subscript(index: Int) -> T? {
        var count = 0
        var current = self
        while count < index {
            guard let next = current.next else {
                return nil
            }
            count++
            current = next
        }
        return current.value
    }
}

extension List {
    /// P04 (*) Find the number of elements of a list.
    /// - complexity: O(n)
    public var length: Int {
        var count = 1
        var current = self
        while let next = current.next {
            count++
            current = next
        }
        return count
    }
}

extension List {
    /// P05 (*) Reverse a list.
    /// - complexity: O(n)
    public func reverse() -> List {
        var head = self
        if next == nil {
            return head
        }
        let current = head
        while let next = current.next {
            current.next = next.next
            next.next = head
            head = next
        }
        return head
    }
}

extension List where T:Equatable {
    /// P06 (*) Find out whether a list is a palindrome.
    /// - complexity: O(2n) = O(n)
    public func isPalindrome() -> Bool {
        var stack: [T] = []
        var current: List? = self
        while let value = current?.value {
            stack.append(value)
            current = current?.next
        }
        current = self
        while let value = current?.value {
            if value != stack.removeLast() {
                return false
            }
            current = current?.next
        }
        return stack.count == 0
    }
}

extension List {
    /// P07 (*) Flatten a nested list structure.
    /// - complexity: O(n)
    public func flatten() -> List {
        var resultList: List!
        var resultListLast: List!
        var current: List? = self
        while let value = current?.value {
            switch value {
            case let list as List:
                let childrenList = list.flatten()
                var currentChild: List! = childrenList
                repeat {
                    let newItem = List(currentChild.value)
                    if resultList == nil {
                        resultList = newItem
                    } else {
                        resultListLast.next = newItem
                    }
                    resultListLast = newItem
                    currentChild = currentChild.next
                } while currentChild != nil
            default:
                let newItem = List(value)
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast.next = newItem
                }
                resultListLast = newItem
            }
            current = current?.next
        }
        return resultList
    }
}

extension List where T: Equatable {
    /// P08 (**) Eliminate consecutive duplicates of list elements.
    /// - complexity: O(n)
    public func compress() -> List {
        let resultList = List(value)
        var resultListLast = resultList
        var current = self
        while let next = current.next {
            if resultListLast.value != next.value {
                resultListLast.next = List(next.value)
                resultListLast = resultListLast.next
            }
            current = next
        }
        return resultList
    }
}

extension List where T: Equatable {
    /// P09 (**) Pack consecutive duplicates of list elements into sublists.
    /// - complexity: O(n)
    public func pack() -> List<List<T>> {
        var resultList: List<List<T>>!
        var resultListLast: List<List<T>>!
        var current: List? = self
        var innerList: List!
        var innerListLast = innerList
        while let value = current?.value {
            let newItem = List(value)
            if innerList == nil {
                innerList = newItem
            } else {
                innerListLast.next = newItem
            }
            innerListLast = newItem
            if value != current?.next?.value {
                let newResultItem = List<List<T>>(innerList)
                if resultList == nil {
                    resultList = newResultItem
                } else {
                    resultListLast.next = newResultItem
                }
                resultListLast = newResultItem
                innerList = nil
                innerListLast = nil
            }
            current = current?.next
        }
        return resultList
    }
}

extension List where T: Equatable {
    /// P10 (*) Run-length encoding of a list.
    /// - complexity: O(n)
    public func encode() -> List<(Int, T)> {
        let packed = pack()
        var resultList: List<(Int, T)>!
        var resultListLast: List<(Int, T)>!
        var current: List<List<T>>? = packed
        while let value = current?.value {
            let newItem = List<(Int, T)>((value.length, value.value))
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItem
            current = current?.next
        }
        return resultList
    }
}

extension List where T: Equatable {
    /// P11 (*) Modified run-length encoding.
    /// - complexity: O(n)
    public func encodeModified() -> List<Any> {
        let packed = pack()
        var resultList: List<Any>!
        var resultListLast: List<Any>!
        var current: List<List<T>>? = packed
        while let value = current?.value {
            let count = value.length
            let value = value.value
            var newItem: List<Any>!
            if count == 1 {
                newItem = List<Any>(value)
            } else {
                // Tuples do not downcast to Any, so pack them as a List instead
                let pack = List<Any>(count, value)
                newItem = List<Any>(pack)
            }
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItem
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P12 (**) Decode a run-length encoded list.
    /// - complexity: O(n)
    public func decode() -> List<String> {
        var resultList: List<String>!
        var resultListLast: List<String>!
        var current: List? = self
        while let value = current?.value as? (Int, String) {
            for _ in 1...value.0 {
                let newItem = List<String>(value.1)
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast.next = newItem
                }
                resultListLast = newItem
            }
            current = current?.next
        }
        return resultList
    }
}

extension List where T: Equatable {
    /// P13 (**) Run-length encoding of a list (direct solution).
    /// - complexity: O(n)
    public func encodeDirect() -> List<(Int, T)> {
        var resultList: List<(Int, T)>!
        var resultListLast: List<(Int, T)>!
        var current: List? = self
        var count = 1
        while let value = current?.value {
            if value == current?.next?.value {
                count++
            } else {
                let newItem = List<(Int, T)>((count, value))
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast.next = newItem
                }
                resultListLast = newItem
                count = 1
            }
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P14 (*) Duplicate the elements of a list.
    /// - complexity: O(n)
    public func duplicate() -> List {
        var resultList: List!
        var resultListLast: List!
        var current: List? = self
        while let value = current?.value {
            let newItem = List(value)
            newItem.next = List(value)
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItem.next
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P15 (**) Duplicate the elements of a list a given number of times.
    /// - complexity: O(n*m)
    public func duplicate(times: Int) -> List {
        var resultList: List!
        var resultListLast: List!
        var current: List? = self
        while let value = current?.value {
            let newItem = List(value)
            var newItemLast = newItem
            for _ in 1..<times {
                let dupe = List(value)
                newItemLast.next = dupe
                newItemLast = dupe
            }
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItemLast
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P16 (**) Drop every Nth element from a list.
    /// - complexity: O(n)
    public func drop(every: Int) -> List? {
        if every < 2 {
            return nil
        }
        var resultList: List?
        var resultListLast: List?
        var current: List? = self
        var index = 1
        while let value = current?.value {
            if index % every != 0 {
                let newItem = List(value)
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P17 (*) Split a list into two parts.
    /// - complexity: O(n)
    public func split(atIndex: Int) -> (left: List?, right: List?) {
        var left: List?
        var leftLast: List?
        var right: List?
        var rightLast: List?
        var index = 0
        var current: List? = self
        while let value = current?.value {
            let newItem = List(value)
            if index < atIndex {
                if left == nil {
                    left = newItem
                } else {
                    leftLast?.next = newItem
                }
                leftLast = newItem
            } else {
                if right == nil {
                    right = newItem
                } else {
                    rightLast?.next = newItem
                }
                rightLast = newItem
            }
            index++
            current = current?.next
        }
        return (left, right)
    }
}

extension List {
    /// P18 (**) Extract a slice from a list.
    /// - complexity: O(n)
    public func slice(from: Int, _ to: Int) -> List? {
        var resultList: List?
        var resultListLast: List?
        var current: List? = self
        var index = 0
        while let value = current?.value {
            if index >= from && index < to {
                let newItem = List(value)
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P19 (**) Rotate a list N places to the left.
    /// - complexity: O(n)
    public func rotate(amount: Int) -> List {
        // Split list in two pieces
        let listLength = length
        let splitIndex = listLength > 0 ? (listLength + amount) % listLength : 0
        let parts = split(splitIndex)

        // Start with second piece and walk to end
        var resultList: List! = parts.1
        var current: List? = resultList
        while let next = current?.next {
            current = next
        }

        // Append first piece
        if resultList == nil {
            resultList = parts.0
        } else {
            current?.next = parts.0
        }
        return resultList
    }
}

extension List {
    /// P20 (*) Remove the Kth element from a list.
    /// - complexity: O(n)
    public func removeAt(position: Int) -> (rest: List?, removed: T?) {
        var resultList: List?
        var resultListLast: List?
        var current: List? = self
        var index = 0
        var item: T?
        while let value = current?.value {
            if index == position {
                item = value
            } else {
                let newItem = List(value)
                if resultList == nil {
                    resultList = newItem
                } else {
                    resultListLast?.next = newItem
                }
                resultListLast = newItem
            }
            index++
            current = current?.next
        }
        return (resultList, item)
    }
}

extension List {
    /// P21 (*) Insert an element at a given position into a list.
    /// - complexity: O(n)
    public func insertAt(index: Int, _ value: T) -> List {
        var resultList: List!
        var resultListLast: List!
        var current: List? = self
        var currentIndex = 1
        while let val = current?.value {
            let newItem = List(val)
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast?.next = newItem
            }
            resultListLast = newItem
            if currentIndex == index {
                newItem.next = List(value)
                resultListLast = resultListLast.next
            }
            currentIndex++
            current = current?.next
        }
        return resultList
    }
}

extension List {
    /// P22 (*) Create a list containing all integers within a given range.
    /// - complexity: O(n)
    public class func range(from: Int, _ to: Int) -> List<Int> {
        var resultList: List<Int>!
        var resultListLast: List<Int>!
        for i in from...to {
            let newItem = List<Int>(i)
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItem
        }
        return resultList
    }
}

extension List {
    /// P23 (**) Extract a given number of randomly selected elements from a list.
    /// - complexity: O(n)
    public func randomSelect(amount: Int) -> List {
        var resultList: List!
        var resultListLast: List!
        var count = 0
        var list: List? = self
        while count < amount {
            let length = list?.length ?? 0
            let index = Int(arc4random_uniform(UInt32(length)))
            let result = list?.removeAt(index)
            list = result?.0
            guard let value = result?.1 else {
                break
            }
            let newItem = List(value)
            if resultList == nil {
                resultList = newItem
            } else {
                resultListLast.next = newItem
            }
            resultListLast = newItem
            count++
        }
        return resultList
    }
}

extension List {
    /// P24 (*) Lotto: Draw N different random numbers from the set 1..M.
    /// - complexity: O(n)
    public class func lotto(numbers: Int, _ maximum: Int) -> List<Int> {
        let numberList = List<Int>.range(1, maximum)
        return numberList.randomSelect(numbers)
    }
}

extension List {
    /// P25 (*) Generate a random permutation of the elements of a list.
    public func randomPermute() -> List {
        return randomSelect(length)
    }
}

extension List {
    /// P26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list.
    /// - complexity: O(n)
    public func combinations(group: Int) -> List<List<T>>? {
        var resultList: List<List<T>>?
        var resultListLast: List<List<T>>?
        if group > 1 {
            var current: List? = self
            var theOthers: List? = self
            while let value = current?.value {
                theOthers = theOthers?.removeAt(0).0
                let theirCombinations = theOthers?.combinations(group-1)
                var innerCurrent = theirCombinations
                while let innerList = innerCurrent?.value {
                    let myCombinations = List(value)
                    var myCombinationsLast = myCombinations
                    var currentItem: List? = innerList
                    while let innerValue = currentItem?.value {
                        let newCombinationItem = List(innerValue)
                        myCombinationsLast?.next = newCombinationItem
                        myCombinationsLast = newCombinationItem
                        currentItem = currentItem?.next
                    }
                    let newItem = List<List<T>>(myCombinations)
                    if resultList == nil {
                        resultList = newItem
                    } else {
                        resultListLast?.next = newItem
                    }
                    resultListLast = newItem
                    innerCurrent = innerCurrent?.next
                }
                current = current?.next
            }
        } else {
            // N groups of 1 item
            var current: List? = self
            while let value = current?.value {
                let newList = List<List<T>>(List(value))
                if resultList == nil {
                    resultList = newList
                } else {
                    resultListLast?.next = newList
                }
                resultListLast = newList
                current = current?.next
            }
        }
        return resultList
    }
}

extension List {
    /// P26B (**) Generate the permutations of K distinct objects chosen from the N elements of a list.
    /// - complexity: O(n)
    public func permutations(group: Int) -> List<List<T>>? {
        var resultList: List<List<T>>?
        var resultListLast: List<List<T>>?
        if group > 1 {
            var current: List? = self
            var index = 0
            while let value = current?.value {
                let theOthers = self.removeAt(index).0
                let theirCombinations = theOthers?.combinations(group-1)
                var innerCurrent = theirCombinations
                while let innerList = innerCurrent?.value {
                    let myCombinations = List(value)
                    var myCombinationsLast = myCombinations
                    var currentItem: List? = innerList
                    while let innerValue = currentItem?.value {
                        let newCombinationItem = List(innerValue)
                        myCombinationsLast?.next = newCombinationItem
                        myCombinationsLast = newCombinationItem
                        currentItem = currentItem?.next
                    }
                    let newItem = List<List<T>>(myCombinations)
                    if resultList == nil {
                        resultList = newItem
                    } else {
                        resultListLast?.next = newItem
                    }
                    resultListLast = newItem
                    innerCurrent = innerCurrent?.next
                }
                index++
                current = current?.next
            }
        } else {
            // N groups of 1 item
            var current: List? = self
            while let value = current?.value {
                let newList = List<List<T>>(List(value))
                if resultList == nil {
                    resultList = newList
                } else {
                    resultListLast?.next = newList
                }
                resultListLast = newList
                current = current?.next
            }
        }
        return resultList
    }
}
