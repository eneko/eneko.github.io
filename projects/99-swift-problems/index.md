---
layout: page
permalink: /99-swift-problems/
title: Ninety-Nine Swift Problems
desc: Ninety-Nine Swift Problems is an adaptation from the Ninety-Nine Scala problems.
keywords: swift, problems, programming, computer, science, cs, swiftlang
image: /media/99-swift-problems/screenshot.jpg
---

Ninety-Nine Swift Problems is a collection of interesting problems that will
help Swift programmers like you learn and practice your skills in logic
programming, data structures and algorithms in the
[Swift programming language](https://swift.org).

This list is an adaptation by me, [Eneko Alonso](http://enekoalonso.com), of the
[Ninety-Nine Scala Problems](http://aperiodic.net/phil/scala/s-99/) written by
[Phil Gold](http://aperiodic.net/phil/), which in turn was an adaptation of the
original [Ninety-Nine Prolog Problems](https://prof.ti.bfh.ch/hew1/informatik3/prolog/p-99/)
written by [Werner Hett](https://sites.google.com/site/prologsite/author) at
Berne University of Applied Sciences in Berne, Switzerland.

From the original:

> The problems have different levels of difficulty. Those marked with a single
asterisk (\*) are easy. If you have successfully solved the preceding problems
you should be able to solve them within a few (say 15) minutes. Problems marked
with two asterisks (\*\*) are of intermediate difficulty. If you are a skilled
programmer it shouldn't take you more than 30-90 minutes to solve them.
Problems marked with three asterisks (\*\*\*) are more difficult. You may need
more time (i.e. a few hours or more) to find a good solution.

> Your goal should be to find the most elegant solution of the given problems.
Efficiency is important, but clarity is even more crucial. Some of the (easy)
problems can be trivially solved using built-in functions. However, in these
cases, you learn more if you try to find your own solution.

I have maintained the difficulties from the Scala and Prolog problems, as they
should also apply to Swift.

Problems are divided in seven categories:

1. [Linked Lists](#linked-lists)
2. [Arithmetic](#arithmetic)
3. [Logic and Codes](#logic-and-codes)
4. [Binary Trees](#binary-trees)
5. [Multiway Trees](#multiway-trees)
6. [Graphs](#graphs)
7. [Miscellaneous Problems](#miscellaneous)

Solutions for these problems can be written in Swift by creating a
Playground in Xcode. Classes and structures can be placed on the source files
folder to keep the Playground clean.

A better way, maybe, would be creating an Xcode project for an iOS, OS X or
tvOS application or framework. This would make it very easy to test your
solutions with Unit Tests and to guarantee 100% code coverage. An OS X
command line application would also work, but it will require more
configuration to get the unit tests ready.

You can also create Swift files without an Xcode project and use `swift`
or `swiftc` on the terminal to run the code. Use `swift build` if you have
[Swift 2.2](https://swift.org/getting-started/) installed.


* * *


## <a name="linked-lists"/> [Section 1:](#linked-lists) Working with Linked Lists

> A list is either empty or it is composed of a first element (head) and a tail,
> which is a list itself.

We are going to solve the problems on this section by using a generic
[Linked List](https://en.wikipedia.org/wiki/Linked_list), starting with the
following signature:

~~~swift
class List<T> {
    var value: T
    var next: List<T>?
}
~~~

The gist [List.swift](https://gist.github.com/eneko/98b0313fa2e7bb529ecf)
contains the basics of the `List` class to get you started,
including a convenience initializer to create lists in the `List(1, 2, 3, ...)`
form, and a implementation of the `CustomStringConvertible` protocol.

Section rules:

- Individual methods or computed properties will be added to the `List<T>`
class as extensions to solve each problem.
- Consider instances of `List` as immutable. All methods should
return new instances of linked lists (instead of modifying the current list).

### <a name="p01"/>[P01](#p01) (\*) Find the last element of a linked list.
Example:

~~~swift
List(1, 1, 2, 3, 5, 8).last
~~~

Result:

~~~swift
8
~~~

Implementation:

~~~swift
extension List {
    var last: T? {
        ...
    }
}
~~~

### <a name="p02"/>[P02](#p02) (\*) Find the last but one element of a linked list.
Example:

~~~swift
List(1, 1, 2, 3, 5, 8).pennultimate
~~~

Result:

~~~swift
5
~~~

Implementation:

~~~swift
extension List {
    var pennultimate: T? {
        ...
    }
}
~~~

### <a name="p03"/>[P03](#p03) (\*) Find the Kth element of a linked list.
By convention, the first element in the list is element `0`. Use Swift
[subscripts](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html) to get the value from the linked list.

Example:

~~~swift
let list = List(1, 1, 2, 3, 5, 8)
list[2]
~~~

Result:

~~~swift
2
~~~

Implementation:

~~~swift
extension List {
    subscript(index: Int) -> T? {
        ...
    }
}
~~~

### <a name="p04"/>[P04](#p04) (\*) Find the number of elements of a linked list.
Example:

~~~swift
List(1, 1, 2, 3, 5, 8).length
~~~

Result:

~~~swift
6
~~~

Implementation:

~~~swift
extension List {
    var length: Int {
        ...
    }
}
~~~

### <a name="p05"/>[P05](#p05) (\*) Reverse a linked list.
Example:

~~~swift
List(1, 1, 2, 3, 5, 8).reverse()
~~~

Result:

~~~swift
List(8, 5, 3, 2, 1, 1)
~~~

Implementation:

~~~swift
extension List {
    func reverse() {
        ...
    }
}
~~~

### <a name="p06"/>[P06](#p06) (\*) Find out whether a linked list is a palindrome.
Example:

~~~swift
List(1, 2, 3, 2, 1).isPalindrome()
~~~

Result:

~~~swift
true
~~~

Implementation:

~~~swift
extension List where T:Equatable {
    func isPalindrome() -> Bool {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p07"/>[P07](#p07) (\*\*) Flatten a nested linked list structure.
Example:

~~~swift
List<Any>(List<Any>(1, 1), 2, List<Any>(3, List<Any>(5, 8))).flatten()
~~~

Result:

~~~swift
List(1, 1, 2, 3, 5, 8)
~~~

Implementation:

~~~swift
extension List {
    func flatten() -> List {
        ...
    }
}
~~~

### <a name="p08"/>[P08](#p08) (\*\*) Eliminate consecutive duplicates of linked list elements.
If a linked list contains repeated elements they should be replaced with a single copy
of the element. The order of the elements should not be changed.

Example:

~~~swift
let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
list.compress()
~~~

Result:

~~~swift
List("a", "b", "c", "a", "d", "e")
~~~

Implementation:

~~~swift
extension List where T: Equatable {
    func compress() {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p09"/>[P09](#p09) (\*\*) Pack consecutive duplicates of linked list elements into sub linked lists.
If a list contains repeated elements they should be placed in separate sub linked lists.

Example:

~~~swift
let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
list.pack()
~~~

Result:

~~~swift
List(List("a", "a", "a", "a"), List("b"), List("c", "c"), List("a", "a"), List("d"), List("e", "e", "e", "e"))
~~~

Implementation:

~~~swift
extension List where T: Equatable {
    func pack() -> List<List<T>> {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p10"/>[P10](#p10) (\*) Run-length encoding of a linked list.
Use the result of problem [P09](#p09) to implement the so-called run-length
encoding data compression method. Consecutive duplicates of elements are
encoded as tuples `(N, E)` where `N` is the number of duplicates of the
element `E`.

Example:

~~~swift
let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
list.encode()
~~~

Result:

~~~swift
List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
~~~

Implementation:

~~~swift
extension List where T: Equatable {
    func encode() -> List<(Int, T)> {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p11"/>[P11](#p11) (\*) Modified run-length encoding.
Modify the result of problem [P10](#p10) in such a way that if an element has no
duplicates it is simply copied into the result linked list. Only elements with
duplicates are transferred as `(N, E)` terms.

Example:

~~~swift
let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
list.encodeModified()
~~~

Result:

~~~swift
List((4, "a"), "b", (2, "c"), (2, "a"), "d", (4, "e"))
~~~

Implementation:

~~~swift
extension List where T: Equatable {
    func encodeModified() -> List<Any> {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p12"/>[P12](#p12) (\*\*) Decode a run-length encoded linked list.
Given a run-length code linked list generated as specified in problem [P10](#p10),
construct its uncompressed version.

Example:

~~~swift
let list = List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
list.decode()
~~~

Result:

~~~swift
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
~~~

Implementation:

~~~swift
extension List {
    func decode() -> List<String> {
        ...
    }
}
~~~

_Note: Implement for `String` only._

### <a name="p13"/>[P13](#p13) (\*\*) Run-length encoding of a linked list (direct solution).
Implement the so-called run-length encoding data compression method directly.
I.e. don't use other methods you've written (like [P09](#p09)'s pack); do all
the work directly.

Example:

~~~swift
let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")
list.encodeDirect()
~~~

Result:

~~~swift
List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e"))
~~~

Implementation:

~~~swift
extension List where T: Equatable {
    func encodeDirect() -> List<(Int, T)> {
        ...
    }
}
~~~

_Note: Requires list elements to conform to `Equatable`._

### <a name="p14"/>[P14](#p14) (\*) Duplicate the elements of a linked list.
Example:

~~~swift
let list = List("a", "b", "c", "c", "d")
list.duplicate()
~~~

Result:

~~~swift
List("a", "a", "b", "b", "c", "c", "c", "c", "d", "d")
~~~

Implementation:

~~~swift
extension List {
    func duplicate() -> List {
        ...
    }
}
~~~

### <a name="p15"/>[P15](#p15) (\*\*) Duplicate the elements of a linked list a given number of times.
Example:

~~~swift
let list = List("a", "b", "c", "c", "d")
list.duplicate(3)
~~~

Result:

~~~swift
List("a", "a", "a", "b", "b", "b", "c", "c", "c", "c", "c", "c", "d", "d", "d")
~~~

Implementation:

~~~swift
extension List {
    func duplicate(times: Int) -> List {
        ...
    }
}
~~~

### <a name="p16"/>[P16](#p16) (\*\*) Drop every Nth element from a linked list.
Example:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
list.drop(3)
~~~

Result:

~~~swift
List("a", "b", "d", "e", "g", "h", "j", "k")
~~~

Implementation:

~~~swift
extension List {
    func drop(every: Int) -> List {
        ...
    }
}
~~~

### <a name="p17"/>[P17](#p17) (\*) Split a linked list into two parts.
The length of the first part is given. Use a Tuple for your result.

Example:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
list.split(3)
~~~

Result:

~~~swift
(List("a", "b", "c"), List("d", "e", "f", "g", "h", "i", "j", "k"))
~~~

Implementation:

~~~swift
extension List {
    func split(atIndex: Int) -> (left: List, right: List) {
        ...
    }
}
~~~

### <a name="p18"/>[P18](#p18) (\*\*) Extract a slice from a linked list.
Given two indices, `I` and `K`, the slice is the linked list containing the elements
from and including the `Ith` element up to but not including the `Kth` element
of the original linked list. Start counting the elements with `0`.

Example:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
list.slice(3, 7)
~~~

Result:

~~~swift
List("d", "e", "f", "g")
~~~

Implementation:

~~~swift
extension List {
    func slice(from: Int, _ to: Int) -> List {
        ...
    }
}
~~~

### <a name="p19"/>[P19](#p19) (\*\*) Rotate a list N places to the left.
Example #1:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
list.rotate(3)
~~~

Result:

~~~swift
List("d", "e", "f", "g", "h", "i", "j", "k", "a", "b", "c")
~~~

Example #2:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k")
list.rotate(-2)
~~~

Result:

~~~swift
List("j", "k", "a", "b", "c", "d", "e", "f", "g", "h", "i")
~~~

Implementation:

~~~swift
extension List {
    func rotate(amount: Int) -> List {
        ...
    }
}
~~~

### <a name="p20"/>[P20](#p20) (\*) Remove the Kth element from a linked list.
Return a linked list without the removed element and the removed element in a
Tuple. Elements are numbered from `0`.

Example:

~~~swift
let list = List("a", "b", "c", "d")
list.removeAt(1)
~~~

Result:

~~~swift
(List("a", "c", "d"), "b")
~~~

Implementation:

~~~swift
extension List {
    func removeAt(position: Int) -> (rest: List?, removed: T?) {
        ...
    }
}
~~~

### <a name="p21"/>[P21](#p21) (\*) Insert an element at a given position into a linked list.
Example:

~~~swift
let list = List("a", "b", "c", "d")
list.insertAt(1, "new")
~~~

Result:

~~~swift
List("a", "new", "b", "c", "d")
~~~

Implementation:

~~~swift
extension List {
    func insertAt(index: Int, _ value: T) {
        ...
    }
}
~~~

### <a name="p22"/>[P22](#p22) (\*) Create a linked list containing all integers within a given range.
Example:

~~~swift
List.range(4, 9)
~~~

Result:

~~~swift
List(4, 5, 6, 7, 8, 9)
~~~

Implementation:

~~~swift
extension List {
    class func range(from: Int, _ to: Int) -> List<Int> {
        ...
    }
}
~~~

_Note: Implement as class function._

### <a name="p23"/>[P23](#p23) (\*\*) Extract a given number of randomly selected elements from a linked list.
Example:

~~~swift
let list = List("a", "b", "c", "d", "e", "f", "g", "h")
list.randomSelect(3)
~~~

Result:

~~~swift
List("e", "d", "a")
~~~

Implementation:

~~~swift
extension List {
    func randomSelect(amount: Int) -> List {
        ...
    }
}
~~~

_Hint: Use the solution to problem [P20](#p20)._

### <a name="p24"/>[P24](#p24) (\*) Lotto: Draw N different random numbers from the set 1..M.
Return a linked list with the _lotto_ numbers.

Example:

~~~swift
List.lotto(6, 49)
~~~

Result:

~~~swift
List(23, 1, 17, 33, 21, 37)
~~~

Implementation:

~~~swift
extension List {
    class func lotto(numbers: Int, _ maximum: Int) -> List<Int> {
        ...
    }
}
~~~

_Note: Implement as class function._

### <a name="p25"/>[P25](#p25) (\*) Generate a random permutation of the elements of a linked list.
Example:

~~~swift
List("a", "b", "c", "d", "e", "f").randomPermute()
~~~

Result:

~~~swift
List("b", "a", "d", "c", "e", "f")
~~~

Implementation:

~~~swift
extension List {
    func randomPermute() -> List {
        ...
    }
}
~~~

_Hint: Use the solution of problem [P23](#p23)._

### <a name="p26"/>[P26](#p26) (\*\*) Generate the combinations of K distinct objects chosen from the N elements of a linked list.
In how many ways can a committee of 3 be chosen from a group of 12 people?
We all know that there are `C(12,3) = 220` possibilities (`C(N,K)` denotes the
well-known binomial coefficient). For pure mathematicians, this result may
be great. But we want to really generate all the possibilities.

Example:

~~~swift
List("a", "b", "c").combinations(2)
~~~

Result:

~~~swift
List(List("a", "b"), List("a", "c"), List("b", "c"))
~~~

Implementation:

~~~swift
extension List {
    func combinations(group: Int) -> List<List<T>> {
        ...
    }
}
~~~

### <a name="p26b"/>[P26B](#p26b) (\*\*) Generate the permutations of K distinct objects chosen from the N elements of a linked list.
In how many ways can 12 people sit on 3 chairs?
Generate all the possible permutations. Eg. `P(12,3) = 660`.

Example:

~~~swift
List("a", "b", "c").permutations(2)
~~~

Result:

~~~swift
List(List("a", "b"), List("a", "c"), List("b", "a"), List("b", "c"), List("c", "a"), List("c", "b"))
~~~

Implementation:

~~~swift
extension List {
    func permutations(group: Int) -> List<List<T>> {
        ...
    }
}
~~~

### <a name="p27"/>[P27](#p27) (\*\*) Group the elements of a set into disjoint subsets.
In how many ways can a group of 9 people work in 3 disjoint subgroups of
2, 3 and 4 persons? Write a function that generates all the possibilities.

Example:

~~~swift
let list = List("Aldo", "Beat", "Carla", "David", "Evi", "Flip", "Gary", "Hugo", "Ida")
list.group3()
~~~

Result:

~~~swift
List(List(List("Aldo", "Beat"), List("Carla", "David", "Evi"), List("Flip", "Gary", "Hugo", "Ida")), ...)
~~~

Implementation:

~~~swift
extension List {
    func group3() -> List<List<List<T>>> {
        ...
    }
}
~~~

Note that we do not want permutations of the group members;
i.e. ((Aldo, Beat), ...) is the same solution as ((Beat, Aldo), ...).
However, we make a difference between ((Aldo, Beat), (Carla, David), ...)
and ((Carla, David), (Aldo, Beat), ...).

You may find more about this combinatorial problem in a good book on discrete
mathematics under the term "multinomial coefficients".

### <a name="p27b"/>[P27B](#p27b) (\*\*) Group the elements of a set into disjoint subsets - Part 2.
Generalize the above predicate in a way that we can specify a list of group
sizes and the predicate will return a list of groups.

Example:

~~~swift
let list = List("Aldo", "Beat", "Carla", "David", "Evi", "Flip", "Gary", "Hugo", "Ida")
list.group(List(2, 2, 5))
~~~

Result:

~~~swift
List(List(List("Aldo", "Beat"), List("Carla", "David"), List("Evi", "Flip", "Gary", "Hugo", "Ida")), ...)
~~~

Implementation:

~~~swift
extension List {
    func group(groups: List<Int>) -> List<List<List<T>>> {
        ...
    }
}
~~~

### <a name="p28"/>[P28](#p28) (\*\*) Sorting a linked list of linked lists according to length of sublists.
We suppose that a linked list contains elements that are linked lists themselves.
The objective is to sort the elements of the list according to their length.
E.g. short lists first, longer lists later, or vice versa.

Example:

~~~swift
let list = List(List("a", "b", "c"), List("d", "e"), List("f", "g", "h"), List("d", "e"), List("i", "j", "k", "l"), List("m", "n"), List("o"))
list.lsort()
~~~

Result:

~~~swift
List(List("o"), List("d", "e"), List("d", "e"), List("m", "n"), List("a", "b", "c"), List("f", "g", "h"), List("i", "j", "k", "l"))
~~~

Implementation:

~~~swift
extension List {
    func lsort() -> List {
        ...
    }
}
~~~

### <a name="p28b"/>[P28B](#p28b) (\*\*) Sorting a linked list of linked lists according to their length frequency.
Again, we suppose that a list contains elements that are lists themselves.
But this time the objective is to sort the elements according to their length
frequency; i.e. in the default, sorting is done ascendingly, lists with rare
lengths are placed, others with a more frequent length come later.

Example:

~~~swift
let list = List(List("a", "b", "c"), List("d", "e"), List("f", "g", "h"), List("d", "e"), List("i", "j", "k", "l"), List("m", "n"), List("o"))
list.lsortFreq()
~~~

Result:

~~~swift
List(List("i", "j", "k", "l"), List("o"), List("a", "b", "c"), List("f", "g", "h"), List("d", "e"), List("d", "e"), List("m", "n"))
~~~

Implementation:

~~~swift
extension List {
    func lsortFreq() -> List {
        ...
    }
}
~~~

Note that in the above example, the first two lists in the result have length
4 and 1 and both lengths appear just once. The third and fourth lists have
length 3 and there are two list of this length. Finally, the last three lists
have length 2. This is the most frequent length.

* * *

## <a name="arithmetic"/> [Section 2:](#arithmetic) Arithmetic

For the next section, we're going to take a different tack with the solutions.
Instead of using a class, we will define the solutions as extensions to `Int`
(both instance and class methods).

### <a name="p31"/>[P31](#p31) (\*\*) Determine whether a given integer number is prime.
Example:

~~~swift
7.isPrime()
~~~

Result:

~~~swift
true
~~~

Implementation:

~~~swift
extension Int {
    func isPrime() -> Bool {
        ...
    }
}
~~~

### <a name="p32"/>[P32](#p32) (\*\*) Determine the greatest common divisor of two positive integer numbers.
Use [Euclid's algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm).

Example:

~~~swift
Int.gcd(36, 63)
~~~

Result:

~~~swift
9
~~~

Implementation:

~~~swift
extension Int {
    class func gcd(first: Int, _ second: Int) -> Int {
        ...
    }
}
~~~

### <a name="p33"/>[P33](#p33) (\*) Determine whether two positive integer numbers are coprime.
Two numbers are [coprime](https://en.wikipedia.org/wiki/Coprime_integers)
if their [greatest common divisor](https://en.wikipedia.org/wiki/Greatest_common_divisor)
equals `1`.

Example:

~~~swift
35.isCoprimeTo(64)
~~~

Result:

~~~swift
true
~~~

Implementation:

~~~swift
extension Int {
    func isCoprimeTo(other: Int) -> Bool {
        ...
    }
}
~~~

### <a name="p34"/>[P34](#p34) (\*\*) Calculate Euler's totient function _phi(m)_.
Euler's so-called [totient function](https://en.wikipedia.org/wiki/Euler%27s_totient_function)
`phi(m)` is defined as the number of positive integers `r (1 <= r <= m)`
that are coprime to `m`.

E.g. `m = 10: r = 1,3,7,9`; thus `phi(m) = 4`.
Note the special case: `phi(1) = 1`.

Example:

~~~swift
10.totient
~~~

Result:

~~~swift
4
~~~

Implementation:

~~~swift
extension Int {
    var totient: Int {
        ...
    }
}
~~~

### <a name="p35"/>[P35](#p35) (\*\*) Determine the prime factors of a given positive integer.
Construct a flat linked list containing the prime factors in ascending order.

Example:

~~~swift
315.primeFactors
~~~

Result:

~~~swift
List(3, 3, 5, 7)
~~~

Implementation:

~~~swift
extension Int {
    var primeFactors: List<Int> {
        ...
    }
}
~~~

### <a name="p36"/>[P36](#p36) (\*\*) Determine the prime factors of a given positive integer - Part 2.
Construct a linked list containing tuples with the prime factors and their multiplicity.

Example:

~~~swift
315.primeFactorMultiplicity
~~~

Result:

~~~swift
List((3, 2), (5, 1), (7, 1))
~~~

Implementation:

~~~swift
extension Int {
    var primeFactorMultiplicity: List<(Int, Int)> {
        ...
    }
}
~~~

Alternatively, use a Dictionary for the result.

Example:

~~~swift
315.primeFactorMultiplicityDict
~~~

Result:

~~~swift
Dictionary([3: 2, 5: 1, 7: 1])
~~~

Implementation:

~~~swift
extension Int {
    var primeFactorMultiplicityDict: Dictionary<Int, Int> {
        ...
    }
}
~~~

### <a name="p37"/>[P37](#37) (\*\*) Calculate Euler's totient function _phi(m)_ (improved).
See problem [P34](#p34) for the definition of Euler's totient function.
If the list of the prime factors of a number `m` is known in the form of
problem [P36](#p36) then the function `phi(m)` can be efficiently calculated
as follows: Let `[[p1, m1], [p2, m2], [p3, m3], ...]` be the list of prime factors
(and their multiplicities) of a given number `m`. Then `phi(m)` can be
calculated with the following formula:

<!-- ~~~
phi(m) = (p1-1)*p1^(m1-1) * (p2-1)*p2^(m2-1) * (p3-1)*p3^(m3-1) * ...
~~~
_Note: `a^b` stands for the `bth` power of `a`._ -->

phi(m) = (p1-1)\*p1<sup>(m1-1)</sup> * (p2-1)\*p2<sup>(m2-1)</sup> * (p3-1)\*p3<sup>(m3-1)</sup> * ...


Implementation:

~~~swift
extension Int {
    var totientImproved: Int {
        ...
    }
}
~~~

### <a name="p38"/>[P38](#p38) (\*) Compare the two methods of calculating Euler's totient function.
Use the solutions of problems [P34](#p38) and [P37](#p37) to compare the
algorithms. Try to calculate `phi(10090)` as an example.

### <a name="p39"/>[P39](#p39) (\*) A linked list of prime numbers.
Given a range of integers by its lower and upper limit, construct a linked list
of all prime numbers in that range.

Example:

~~~swift
Int.listPrimesinRange(7...31)
~~~

Result:

~~~swift
List(7, 11, 13, 17, 19, 23, 29, 31)
~~~

Implementation:

~~~swift
extension Int {
    class func listPrimesInRange(range: Range<Int>) -> List<Int> {
        ...
    }
}
~~~

### <a name="p40"/>[P40](#40) (\*\*) Goldbach's conjecture.
[Goldbach's conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture)
says that every positive even number greater than `2`
is the sum of two prime numbers. E.g. `28 = 5 + 23`. It is one of the most
famous facts in number theory that has not been proved to be correct in the
general case. It has been numerically confirmed up to very large numbers
(much larger than Swift's Int can represent). Write a function to find
two prime numbers that sum up to a given even integer.

Example:

~~~swift
28.goldbach()
~~~

Result:

~~~swift
(5, 23)
~~~

Implementation:

~~~swift
extension Int {
    func goldbach() -> (Int, Int) {
        ...
    }
}
~~~

### <a name="p41"/>[P41](#p41) (\*\*) A list of Goldbach compositions.
Given a range of integers by its lower and upper limit, print a list of all
even numbers and their Goldbach composition.

Example:

~~~swift
Int.printGoldbachList(9...20)
~~~

Output:

~~~
10 = 3 + 7
12 = 5 + 7
14 = 3 + 11
16 = 3 + 13
18 = 5 + 13
20 = 3 + 17
~~~

Implementation:

~~~swift
extension Int {
    class func printGoldbachList() {
        ...
    }
}
~~~

In most cases, if an even number is written as the sum of two prime numbers,
one of them is very small. Very rarely, the primes are both bigger than, say,
`50`. Try to find out how many such cases there are in the range `2...3000`.

Example (minimum value of `50` for the primes):

~~~swift
Int.printGoldbachListLimited(1...2000, 50)
~~~

Output:

~~~
992 = 73 + 919
1382 = 61 + 1321
1856 = 67 + 1789
1928 = 61 + 1867
~~~

Implementation:

~~~swift
extension Int {
    class func printGoldbachListLimited() {
        ...
    }
}
~~~


* * *

## <a name="logic-and-codes"/> [Section 3:](#logic-and-codes) Logic and Codes

Because this is a short section, we will create global functions.

### <a name="p46"/>[P46](#p46) (\*\*) Truth tables for logical expressions.
Define functions `and`, `or`, `nand`, `nor`, `xor`, `impl`, and `equ`
(for logical equivalence) which return `true` or `false` according to the
result of their respective operations; e.g. `and(A, B)` is `true` if and only
if both `A` and `B` are `true`.

- `and` - [Logical Conjunction AND](http://en.wikipedia.org/wiki/Logical_conjunction)
- `or` - [Logical Disjunction OR](http://en.wikipedia.org/wiki/Logical_disjunction)
- `nand` - [Logical NAND](http://en.wikipedia.org/wiki/Logical_NAND)
- `nor` - [Logical NOR](http://en.wikipedia.org/wiki/Logical_NOR)
- `xor` - [Exclusive Disjunction XOR](http://en.wikipedia.org/wiki/Exclusive_or)
- `impl` - [Logical Implication](https://en.wikipedia.org/wiki/Material_conditional)
- `equ` - [Logical Equality XNOR](https://en.wikipedia.org/wiki/Logical_equality)

Example #1:

~~~swift
and(true, true)
~~~

Result:

~~~swift
true
~~~

Example #2:

~~~swift
xor(true, true)
~~~

Result:

~~~swift
false
~~~

Implementation:

~~~swift
func and(a: Bool, b: Bool) -> Bool) {
    ...
}
~~~

A logical expression in two variables can be written as a [closure in Swift](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)
with two parameters:

~~~swift
{ (a: Bool, b: Bool) -> Bool in and(or(a, b), nand(a, b)) }

{ (a, b) in and(or(a, b), nand(a, b)) } // Type Inference

{ and(or($0, $1), nand($0, $1)) } // Shorthand Argument Names
~~~

Now, write a function called `table` which generates the
[truth table](https://en.wikipedia.org/wiki/Truth_table)
of a given logical expression in two variables and returns it as a series of
linked lists.

Example:

~~~swift
table({ and($0, or($0, $1)) })
~~~

Result:

~~~swift
// (A, B, Result)
List(
  List(true,  true,  true ),
  List(true,  false, true ),
  List(false, true,  false),
  List(false, false, false)
)
~~~

Implementation:

~~~swift
func table(expression: (a: Bool, b: Bool) -> Bool) -> List<List<Bool>> {
    ...
}
~~~

### <a name="p47"/>[P47](#p47) (\*) Truth tables for logical expressions - Part 2.
Continue problem [P46](#p46) by redefining `and`, `or`, etc. as infix operators
with left associativity and the corresponding precedence.

Use the following list of mathematical symbols:

- `∧` - [Logical Conjunction AND](http://en.wikipedia.org/wiki/Logical_conjunction)
- `∨` - [Logical Disjunction OR](http://en.wikipedia.org/wiki/Logical_disjunction)
- `⊼` - [Logical NAND](http://en.wikipedia.org/wiki/Logical_NAND)
- `⊽` - [Logical NOR](http://en.wikipedia.org/wiki/Logical_NOR)
- `⊕` - [Exclusive Disjunction  XOR](http://en.wikipedia.org/wiki/Exclusive_or)
- `→` - [Logical Implication](https://en.wikipedia.org/wiki/Material_conditional)
- `≡` - [Logical Equality XNOR](https://en.wikipedia.org/wiki/Logical_equality)

Example:

~~~swift
table({ $0 ∧ $0 ∨ $1 })
~~~

Result:

~~~swift
// (A, B, Result)
List(
  List(true,  true,  true ),
  List(true,  false, true ),
  List(false, true,  false),
  List(false, false, false)
)
~~~

<!-- Implementation:

~~~swift
infix operator ∧ { associativity left precedence 140 }
func ∧ (a: Bool, b: Bool) -> Bool {
    ...
}
~~~ -->

_Note: Use operator precedence to avoid the need of parentheses._

### <a name="p48"/>[P48](#p48) (\*\*) Truth tables for logical expressions - Part 3.
Generalize problem [P47](#p47) in such a way that the logical expression may
contain any number of logical variables. Define `table` in a way that
`table(variableNum, expression)` generates the truth table for the expression for
all the logical variables, and returns it as a series of linked lists.

Example:

~~~swift
table(3, expression: { vars in vars[0] ∧ vars[1] ∨ vars[2] })
~~~

Result:

~~~swift
// (A, B, C, Result)
List(
  List(true,  true,  true,  true ),
  List(true,  true,  false, true ),
  List(true,  false, true,  true ),
  List(true,  false, false, false),
  List(false, true,  true,  true ),
  List(false, true,  false, false),
  List(false, false, true,  true ),
  List(false, false, false, false)
)
~~~

Implementation:

~~~swift
func table(variables: Int, expression: (vars: [Bool]) -> Bool) -> List<List<Bool>> {
    ...
}
~~~

### <a name="p48"/>[P48](#p49) (\*\*) Gray code.
An n-bit Gray code is a sequence of n-bit strings constructed according to
certain rules. For example,

~~~
n = 1: C(1) = ("0", "1").
n = 2: C(2) = ("00", "01", "11", "10").
n = 3: C(3) = ("000", "001", "011", "010", "110", "111", "101", "100").
~~~

Find out the construction rules and write a function to generate Gray codes.

Example:

~~~swift
gray(3)
~~~

Result:

~~~swift
List("000", "001", "011", "010", "110", "111", "101", "100")
~~~

Implementation:

~~~swift
func gray(number: Int) -> List<String> {
    ...
}
~~~

See if you can use [memoization](https://en.wikipedia.org/wiki/Memoization)
to make the function more efficient.

### <a name="p50"/>[P50](#p50) (\*\*\*) Huffman code.
First of all, consult a good book on discrete mathematics or algorithms for
a detailed description of Huffman codes!

We suppose a set of symbols with their frequencies, given as a list of `(S, F)`
Tuples. E.g. `(("a", 45), ("b", 13), ("c", 12), ("d", 16), ("e", 9), ("f", 5))`.
Our objective is to construct a linked list of `(S, C)` Tuples,
where `C` is the Huffman code word for the symbol `S`.

Example:

~~~swift
huffman(List(("a", 45), ("b", 13), ("c", 12), ("d", 16), ("e", 9), ("f", 5)))
~~~

Result:

~~~swift
List(("a", "0"), ("b", "101"), ("c", "100"), ("d", "111"), ("e", "1101"), ("f", "1100"))
~~~

Implementation:

~~~swift
func huffman(symbols: List<(String, Int)>) -> List<(String, String)> {
    ...
}
~~~



* * *

## <a name="binary-trees"/> [Section 4:](#binary-trees) Binary Trees

> A binary tree is either empty or it is composed of a root element and two successors, which are binary trees themselves.

We will define our generic tree as follows:

~~~swift
class Tree<T> {
    var value: T
    var left: Tree<T>?
    var right: Tree<T>?

    init(_ value: T, _ left: Tree<T>? = nil, _ right: Tree<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}
~~~

A tree with only a root node would be `Tree("a")` and an empty tree would be `nil`.

![](/media/99-swift-problems/p67.gif)

The example tree above is given by:

~~~swift
Tree("a", Tree("b", Tree("d"), Tree("e")), Tree("c", nil, Tree("f", Tree("g"), nil)))
~~~

Throughout this section, we will be adding methods to the `Tree` class above
as extensions to solve each problem.

Leaf nodes (nodes with no subtrees) will be displayed in the results below as
`Tree("a")` instead of `Tree("a", nil, nil)`. However, nodes with one subtree
will always display the tree constructor parameters.

### <a name="p54"/>[P54](#p54) (\*) Completely balanced trees.
In a completely balanced binary tree, the following property holds for every
node: The number of nodes in its left subtree and the number of nodes in its
right subtree are almost equal, which means their difference is not greater
than one (_do not confuse with height-balanced trees where the difference in
height is less or equal than one_).

Example:

~~~swift
Tree(1, Tree(2), Tree(3)).isCompletelyBalanced()
~~~

Result:

~~~swift
true
~~~

Implementation:

~~~swift
extension Tree {
    func isCompletelyBalanced() -> Bool {
        ...
    }
}
~~~

_Note: Original problem 'P54 Check whether a given term represents a binary tree'
does not apply to Swift, since our tree representation will only allow
well-formed trees._

### <a name="p55"/>[P55](#p55) (\*\*) Construct completely balanced binary trees.
Write a class method `Tree<T>.makeBalancedTrees()` to construct
completely balanced binary trees for a given number of nodes. The function
should generate all solutions, returning them on a linked list.
The function should take as parameters the
number of nodes and a single value to put in all of them.

Example:

~~~swift
Tree.makeBalancedTrees(nodes: 4, value: "x")
~~~

Result:

~~~swift
List(
    Tree("x", Tree("x"), Tree("x", nil, Tree("x"))),
    Tree("x", Tree("x"), Tree("x", Tree("x"), nil)),
    Tree("x", Tree("x", nil, Tree("x")), Tree("x")),
    Tree("x", Tree("x", Tree("x"), nil), Tree("x"))
)
~~~

Implementation:

~~~swift
extension Tree {
    class func makeBalancedTrees(nodes nodes: Int, value: T) -> List<Tree<T>>? {
        ...
    }
}
~~~

### <a name="p56"/>[P56](#p56) (\*\*) Symmetric binary trees.
Let us call a binary tree symmetric if you can draw a vertical line through
the root node and then the right subtree is the mirror image of the left
subtree. Add an `isSymmetric()` method to the `Tree` class to check whether a
given binary tree is symmetric.

_Hint:_ Write an `isMirrorOf()` method first to check
whether one tree is the mirror image of another. We are only interested in
the structure, not in the contents of the nodes.

Example:

~~~swift
Tree("a", Tree("b"), Tree("c")).isSymmetric()
~~~

Result:

~~~swift
true
~~~

Implementation:

~~~swift
extension Tree {
    func isSymetric() -> Bool {
        ...
    }
}
~~~

### <a name="p57"/>[P57](#p57) (\*\*) Binary search trees.
Write a function to add an element to a binary search tree.

Example:

~~~swift
let tree = Tree(2)
tree.addValue(3)
~~~

Result:

~~~swift
Tree(2, nil, Tree(3))
~~~

Continue:

~~~swift
tree.addValue(0)
~~~

Result:

~~~swift
Tree(2, Tree(0), Tree(3))
~~~

Implementation:

~~~swift
extension Tree {
    func addValue(value: T) -> Tree {
        ...
    }
}
~~~

### <a name="p57b"/>[P57B](#p57b) (\*\*) Binary search trees from Linked List.
Use the function from [P57](#p57) to construct a binary tree from a list of
integers. Define a convenience initializer as follows:

Example:

~~~swift
Tree(list: List(3, 2, 5, 7, 1))
~~~

Result:

~~~swift
Tree(3, Tree(2, Tree(1), nil), Tree(5, nil, Tree(7)))
~~~

Implementation:

~~~swift
extension Tree {
    convenience init(list: List<T>) {
        ...
    }
}
~~~

Then, use this initializer to test your solution to [P56](#p56).

Example:

~~~swift
Tree(list: List(5, 3, 18, 1, 4, 12, 21)).isSymmetric()
~~~

Result:

~~~swift
true
~~~

Example:

~~~swift
Tree(list: List(3, 2, 5, 7, 4)).isSymmetric()
~~~

Result:

~~~swift
false
~~~

### <a name="p58"/>[P58](#p58) (\*\*) Generate-and-test paradigm.
Apply the generate-and-test paradigm to construct all symmetric, completely
balanced binary trees with a given number of nodes.

Example:

~~~swift
Tree.makeSymmetricBalancedTrees(nodes: 5, value: "x")
~~~

Result:

~~~swift
List(
    Tree("x", Tree("x", nil, Tree("x")), Tree("x", Tree("x"), nil)),
    Tree("x", Tree("x", Tree("x"), nil), Tree("x", nil, Tree("x")))
)
~~~

Implementation:

~~~swift
extension Tree {
    class func makeSymmetricBalancedTrees(nodes nodes: Int, value: T) -> List<Tree<T>>? {
        ...
    }
}
~~~

### <a name="p59"/>[P59](#p59) (\*\*) Construct height-balanced binary trees.
In a height-balanced binary tree, the following property holds for every node:
The height of its left subtree and the height of its right subtree are almost
equal, which means their difference is not greater than one.

Write a method `Tree<T>.makeHeightBalancedTrees()` to construct height-balanced
binary trees for a given height with a supplied value for the nodes. The
function should generate all solutions.

Example:

~~~swift
Tree.makeHeightBalancedTrees(height: 3, value: "x")
~~~

Result:

~~~swift
List(
    Tree("x", Tree("x", Tree("x"), Tree("x")), Tree("x", Tree("x"), Tree("x"))),
    Tree("x", Tree("x", Tree("x"), Tree("x")), Tree("x", Tree("x"), nil),
    ...
)
~~~

Implementation:

~~~swift
extension Tree {
    class func makeHeightBalancedTrees(height height: Int, value: T) -> List<Tree<T>>? {
        ...
    }
}
~~~

### <a name="p60"/>[P60](#p60) (\*\*) Construct height-balanced binary trees with a given number of nodes.
Consider a height-balanced binary tree of height *h*. What is the maximum number
of nodes it can contain? Clearly, *MaxN = 2<sup>h</sup> - 1*. However, what is the minimum
number *MinN*? This question is more difficult. Try to find a recursive
statement and turn it into a function `minNodesForBalancedTreeOfHeight()`
that takes a height and returns *MinN*.

Example:

~~~swift
minNodesForBalancedTreeOfHeight(3)
~~~

Result:

~~~swift
4
~~~

On the other hand, we might ask: what is the maximum height *h* a
height-balanced binary tree with *n* nodes can have? Write a
`maxHeightForBalancedTreeWithNodeCount()` function.

Example:

~~~swift
maxHeightForBalancedTreeWithNodeCount(4)
~~~

Result:

~~~swift
3
~~~

Now, we can attack the main problem: construct all the height-balanced binary
trees with a given number of nodes.

Example:

~~~swift
Tree.makeHeightBalancedTrees(nodes: 4, value: "x")
~~~

Result:

~~~swift
List(
    Tree("x", Tree("x", Tree("x"), nil), Tree("x"),
    Tree("x", Tree("x", nil, Tree("x")), Tree("x"),
    ...
)
~~~

Implementation:

~~~swift
extension Tree {
    class func makeHeightBalancedTrees(nodes nodes: Int, value: T) -> List<Tree<T>>? {
        ...
    }
}
~~~

Find out how many height-balanced trees exist for `N = 15`.

### <a name="p61"/>[P61](#p61) (\*) Count the leaves of a binary tree.
A leaf is a node with no successors. Write a computed property `leafCount` to
count them.

Example:

~~~swift
Tree("x", Tree("x"), nil).leafCount
~~~

Result:

~~~swift
1
~~~

Implementation:

~~~swift
extension Tree {
    var leafCount: Int {
        ...
    }
}
~~~

### <a name="p61a"/>[P61A](#p61a) (\*) Collect the leaves of a binary tree in a linked list.
A leaf is a node with no successors. Write a method `leafList()` to collect them
in a linked list.

Example:

~~~swift
Tree("a", Tree("b"), Tree("c", Tree("d"), Tree("e"))).leafList()
~~~

Result:

~~~swift
List("b", "d", "e")
~~~

Implementation:

~~~swift
extension Tree {
    func leafList() -> List<T> {
        ...
    }
}
~~~

### <a name="p62"/>[P62](#p62) (\*) Collect the internal nodes of a binary tree in a linked list.
An internal node of a binary tree has either one or two non-empty successors.
Write a method `internalList()` to collect them in a linked list.

Example:

~~~swift
Tree("a", Tree("b"), Tree("c", Tree("d"), Tree("e"))).internalList()
~~~

Result:

~~~swift
List("a", "c")
~~~

Implementation:

~~~swift
extension Tree {
    func internalList() -> List<T> {
        ...
    }
}
~~~

### <a name="p62b"/>[P62B](#p62b) (\*) Collect the nodes at a given level in a linked list.
A node of a binary tree is at level *n* if the path from the root to the node
has length *n-1*. The root node is at level 1. Write a method `atLevelList()`
to collect all nodes at a given level in a linked list.

Example:

~~~swift
Tree("a", Tree("b"), Tree("c", Tree("d"), Tree("e"))).atLevelList(2)
~~~

Result:

~~~swift
List("b", "c")
~~~

Implementation:

~~~swift
extension Tree {
    func atLevelList() -> List<T> {
        ...
    }
}
~~~

Using `atLevelList()` it is easy to construct a method `levelOrder()` which
creates the level-order sequence (traversal) of the nodes. However, there are
more efficient ways to do that.

### <a name="p63"/>[P63](#p63) (\*\*) Construct a complete binary tree.
A *complete* binary tree with height *h* is defined as follows: The levels
*1,2,3,...,h-1* contain the maximum number of nodes (i.e 2<sup>(i-1)</sup> at
the level *i*, note that we start counting the levels from 1 at the root).
In level *h*, which may contain less than the maximum possible number of
nodes, all the nodes are "left-adjusted". This means that in a level-order
tree traversal all internal nodes come first, the leaves come second,
and empty successors (the *nils* which are not really nodes!) come last.

Particularly, complete binary trees are used as data structures (or addressing
schemes) for heaps.

We can assign an address number to each node in a complete binary tree by
enumerating the nodes in level-order, starting at the root with number 1.
In doing so, we realize that for every node *x* with address *a* the following
property holds: The address of *x* left and right successors are *2\*a* and
*2\*a+1*, respectively, supposed the successors do exist. This fact can be
used to elegantly construct a complete binary tree structure. Write a
method `makeCompleteBinaryTree()` that takes as parameters the number of nodes
and the value to put in each node.

Example:

~~~swift
Tree.makeCompleteTree(nodes: 6, value: "x")
~~~

Result:

~~~swift
Tree("x", Tree("x", Tree("x"), Tree("x")), Tree("x", T("x"), nil))
~~~

Implementation:

~~~swift
extension Tree {
    class func makeCompleteTree(nodes nodes: Int, value: T) -> Tree<T>? {
        ...
    }
}
~~~

### <a name="p64"/>[P64](#p64) (\*\*) Layout a binary tree.
As a preparation for drawing a tree, a layout algorithm is required to
determine the position of each node in a rectangular grid. Several layout
methods are conceivable, one of them is shown in the illustration below.

![p64](/media/99-swift-problems/p64.gif)

In this layout strategy, the position of a node *v* is obtained by the
following two rules:

- *x(v)* is equal to the position of the node *v* in the in-order sequence
- *y(v)* is equal to the depth of the node *v* in the tree

In order to store the position of the nodes, we add a new class with the
additional information.

~~~swift
public class PositionedTree<T> : Tree<T> {
    var x: Int
    var y: Int

    public init(_ value: T, _ left: Tree<T>? = nil, _ right: Tree<T>? = nil, x: Int, y: Int) {
        self.x = x
        self.y = y
        super.init(value, left, right)
    }
}
~~~

Write a method layoutBinaryTree that turns a tree of normal Nodes into a
tree of PositionedNodes.

scala> Node('a', Node('b', End, Node('c')), Node('d')).layoutBinaryTree
res0: PositionedNode[Char] = T[3,1](a T[1,2](b . T[2,3](c . .)) T[4,2](d . .))

The tree above may be constructed with:

~~~swift
Tree(list: List("n", "k", "m", "c", "a", "h", "g", "e", "u", "p", "s", "q"))
~~~

Use it to check your code.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p65"/>[P65](#p65) (\*\*) Layout a binary tree - Part 2.
An alternative layout method is depicted in the following illustration. Find
out the rules and write the corresponding method.

![p65](/media/99-swift-problems/p65.gif)

_Hint:_ On a given level,
the horizontal distance between neighboring nodes is constant.
Use the same conventions as in problem [P64](#p64).

scala> Node('a', Node('b', End, Node('c')), Node('d')).layoutBinaryTree2
res0: PositionedNode[Char] = T[3,1]('a T[1,2]('b . T[2,3]('c . .)) T[5,2]('d . .))

The tree at right may be constructed with Tree.fromList(List('n','k','m','c','a','e','d','g','u','p','q')). Use it to check your code.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p66"/>[P66](#p66) (\*\*\*) Layout a binary tree - Part 3.
Yet another layout strategy is shown in the following illustration. The method
yields a very compact layout while maintaining a certain symmetry in every
node. Find out the rules and write the corresponding method.

![p66](/media/99-swift-problems/p66.gif)

_Hint:_ Consider
the horizontal distance between a node and its successor nodes. How tight
can you pack together two subtrees to construct the combined binary tree?
Use the same conventions as in problem P64 and P65. Note: This is a difficult
problem. Don't give up too early!

scala> Node('a', Node('b', End, Node('c')), Node('d')).layoutBinaryTree3
res0: PositionedNode[Char] = T[2,1]('a T[1,2]('b . T[2,3]('c . .)) T[3,2]('d . .))

Which layout do you like most?

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p67"/>[P67](#p67) (\*\*) A string representation of binary trees.

![p67](/media/99-swift-problems/p67.gif)

Somebody represents binary trees as strings of the following type:

    a(b(d,e),c(,f(g,)))

Write a method which generates this string representation, if the tree is
given as usual (using our `Tree` class). Use that method for the `Tree` class's
`description` methods (`CustomStringConvertible` protocol).
Then write a new convenience initializer which
does this inverse; i.e. given the string representation, construct the tree
in the usual form.

For simplicity, suppose the information in the nodes is a single letter and
there are no spaces in the string.

scala> Node('a', Node('b', Node('d'), Node('e')), Node('c', End, Node('f', Node('g'), End))).toString
res0: String = a(b(d,e),c(,f(g,)))

scala> Tree.fromString("a(b(d,e),c(,f(g,)))")
res1: Node[Char] = a(b(d,e),c(,f(g,)))

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p68"/>[P68](#p68) (\*\*) Preorder and inorder sequences of binary trees.
We consider binary trees with nodes that are identified by single lower-case
letters, as in the example of problem [P67](#p67).

a) Write methods preorder and inorder that construct the preorder and inorder
sequence of a given binary tree, respectively. The results should be lists,
e.g. List('a','b','d','e','c','f','g') for the preorder sequence of the
example in problem [P67](#p67).

scala> Tree.string2Tree("a(b(d,e),c(,f(g,)))").preorder
res0: List[Char] = List(a, b, d, e, c, f, g)

scala> Tree.string2Tree("a(b(d,e),c(,f(g,)))").inorder
res1: List[Char] = List(d, b, e, a, c, g, f)

b) If both the preorder sequence and the inorder sequence of the nodes of a
binary tree are given, then the tree is determined unambiguously. Write a
method preInTree that does the job.

scala> Tree.preInTree(List('a', 'b', 'd', 'e', 'c', 'f', 'g'), List('d', 'b', 'e', 'a', 'c', 'g', 'f'))
res2: Node[Char] = a(b(d,e),c(,f(g,)))

What happens if the same character appears in more than one node? Try, for
instance, Tree.preInTree(List('a', 'b', 'a'), List('b', 'a', 'a')).

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p69"/>[P69](#p69) (\*\*) Dotstring representation of binary trees.
We consider again binary trees with nodes that are identified by single
lower-case letters, as in the example of problem [P67](#p67). Such a tree can be
represented by the preorder sequence of its nodes in which dots `.` are
inserted where an empty subtree (`nil`) is encountered during the tree
traversal. For example, the tree shown in problem [P67](#p67) is represented as
`"abd..e..c.fg..."`. First, try to establish a syntax (BNF or syntax diagrams)
and then write two methods, toDotstring and fromDotstring, which do the
conversion in both directions.

scala> Tree.string2Tree("a(b(d,e),c(,f(g,)))").toDotstring
res0: String = abd..e..c.fg...

scala> Tree.fromDotstring("abd..e..c.fg...")
res1: Node[Char] = a(b(d,e),c(,f(g,)))

The file containing the full class definitions for this section is tree.scala.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)


* * *



## <a name="multiway-trees"/> [Section 5:](#multiway-trees) Multiway Trees

> A multiway tree is composed of a root element and a (possibly empty) set of
> successors which are multiway trees themselves. A multiway tree is never empty.
> The set of successor trees is sometimes called a forest.

![](/media/99-swift-problems/p70.gif)

The code to represent these is somewhat simpler than the code for binary
trees, partly because we don't separate classes for nodes and terminators,
and partly because we don't need the restriction that the value type be ordered.

~~~
case class MTree[+T](value: T, children: List[MTree[T]]) {
  def this(value: T) = this(value, List())
  override def toString = "M(" + value.toString + " {" + children.map(_.toString).mkString(",") + "})"
}

object MTree {
  def apply[T](value: T) = new MTree(value, List())
  def apply[T](value: T, children: List[MTree[T]]) = new MTree(value, children)
}
~~~

The example tree is, thus:

MTree('a', List(MTree('f', List(MTree('g'))), MTree('c'), MTree('b', List(MTree('d'), MTree('e')))))
The starting code skeleton for this section is mtree1.scala.

### <a name="p70b"/>[P70B](#p70b) Omitted; we can only create well-formed trees.

### <a name="p70c"/>[P70C](#p70c) (\*) Count the nodes of a multiway tree.
Write a method nodeCount which counts the nodes of a given multiway tree.

scala> MTree('a', List(MTree('f'))).nodeCount
res0: Int = 2

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p70"/>[P70](#p70) (\*\*) Tree construction from a node string.
We suppose that the nodes of a multiway tree contain single characters.
In the depth-first order sequence of its nodes, a special character ^ has
been inserted whenever, during the tree traversal, the move is a backtrack
to the previous level.

![p70](/media/99-swift-problems/p70.gif)

By this rule, the tree in the figure opposite is represented as:

afg^^c^bd^e^^^

Define the syntax of the string and write a function string2MTree to construct
an MTree from a String. Make the function an implicit conversion from String.
Write the reverse function, and make it the toString method of MTree.

scala> MTree('a', List(MTree('f', List(MTree('g'))), MTree('c'), MTree('b', List(MTree('d'), MTree('e'))))).toString
res0: String = afg^^c^bd^e^^^

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p71"/>[P71](#p71) (\*) Determine the internal path length of a tree.
We define the internal path length of a multiway tree as the total sum of the
path lengths from the root to all nodes of the tree. By this definition, the
tree in the figure of problem P70 has an internal path length of 9. Write a
method internalPathLength to return that sum.

scala> "afg^^c^bd^e^^^".internalPathLength
res0: Int = 9

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p72"/>[P72](#p72) (\*) Construct the postorder sequence of the tree nodes.
Write a method postorder which constructs the postorder sequence of the
nodes of a multiway tree. The result should be a List.

scala> "afg^^c^bd^e^^^".postorder
res0: List[Char] = List(g, f, c, d, e, b, a)

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p73"/>[P73](#p73) (\*\*) Lisp-like tree representation.
There is a particular notation for multiway trees in Lisp. Lisp is a
prominent functional programming language. In Lisp almost everything is a list.
Our example tree would be represented in Lisp as (a (f g) c (b d e)).

The following pictures give some more examples.

![p73](/media/99-swift-problems/p73.png)

Note that in the "lispy" notation a node with successors (children) in the
tree is always the first element in a list, followed by its children.
The "lispy" representation of a multiway tree is a sequence of atoms and
parentheses '(' and ')', with the atoms separated by spaces. We can
represent this syntax as a Scala String. Write a method lispyTree which
constructs a "lispy string" from an MTree.

scala> MTree("a", List(MTree("b", List(MTree("c"))))).lispyTree
res0: String = (a (b c))

As a second, even more interesting, exercise try to write a method that
takes a "lispy" string and turns it into a multiway tree.

[Note: Much of this problem is taken from the wording of the same problem
in the Prolog set. This is certainly one way of looking at Lisp notation,
but it's not how the language actually represents that syntax internally.
I can elaborate more on this, if requested. <PMG>]

The complete source file for this section is mtree.scala.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)


* * *



## <a name="graphs"/> [Section 6:](#graphs) Graphs

> A graph is defined as a set of nodes and a set of edges, where each edge is
> a pair of nodes.

The class to represent a graph is mutable, which isn't in keeping with pure
functional programming, but a pure functional data structure would make
things much, much more complicated. [Pure functional graphs with cycles
require laziness; I think Scala can handle it, but I think that would add
too much of a barrier to the following questions. <PMG>]

Our Graphs use an incidence list internally. Each has a list of nodes and a
list of edges. Each node also has a list of edges that connect it to other
nodes. In a directed graph, nodes that are the target of arcs do not have
references to those arcs in their adjacency list.

~~~
abstract class GraphBase[T, U] {
  case class Edge(n1: Node, n2: Node, value: U) {
    def toTuple = (n1.value, n2.value, value)
  }
  case class Node(value: T) {
    var adj: List[Edge] = Nil
    def neighbors: List[Node] = adj.map(edgeTarget(_, this).get)
  }

  var nodes: Map[T, Node] = Map()
  var edges: List[Edge] = Nil

  // If the edge E connects N to another node, returns the other node,
  // otherwise returns None.
  def edgeTarget(e: Edge, n: Node): Option[Node]

  override def equals(o: Any) = o match {
    case g: GraphBase[T,U] => (nodes.keys.toList -- g.nodes.keys.toList == Nil &&
                               edges.map(_.toTuple) -- g.edges.map(_.toTuple) == Nil)
    case _ => false
  }

  def addNode(value: T) = {
    val n = new Node(value)
    nodes = Map(value -> n) ++ nodes
    n
  }
}

class Graph[T, U] extends GraphBase[T, U] {
  override def equals(o: Any) = o match {
    case g: Graph[T,U] => super.equals(g)
    case _ => false
  }

  def edgeTarget(e: Edge, n: Node): Option[Node] =
    if (e.n1 == n) Some(e.n2)
    else if (e.n2 == n) Some(e.n1)
    else None

  def addEdge(n1: T, n2: T, value: U) = {
    val e = new Edge(nodes(n1), nodes(n2), value)
    edges = e :: edges
    nodes(n1).adj = e :: nodes(n1).adj
    nodes(n2).adj = e :: nodes(n2).adj
  }
}

class Digraph[T, U] extends GraphBase[T, U] {
  override def equals(o: Any) = o match {
    case g: Digraph[T,U] => super.equals(g)
    case _ => false
  }

  def edgeTarget(e: Edge, n: Node): Option[Node] =
    if (e.n1 == n) Some(e.n2)
    else None

  def addArc(source: T, dest: T, value: U) = {
    val e = new Edge(nodes(source), nodes(dest), value)
    edges = e :: edges
    nodes(source).adj = e :: nodes(source).adj
  }
}
~~~

The full initial Graph code, which also includes objects for creating graphs,
is in graph1.scala.

There are a few ways to create a graph from primitives. The graph-term form
lists the nodes and edges separately:

Graph.term(List('b', 'c', 'd', 'f', 'g', 'h', 'k'),
           List(('b', 'c'), ('b', 'f'), ('c', 'f'), ('f', 'k'), ('g', 'h')))

The adjacency-list form associates each node with its adjacent nodes. In an
undirected graph, care must be taken to ensure that all links are
symmetric--if b is adjacent to c, c must also be adjacent to b.

Graph.adjacent(List(('b', List('c', 'f')), ('c', List('b', 'f')), ('d', Nil),
                    ('f', List('b', 'c', 'k')), ('g', List('h')), ('h', List('g')),
                    ('k', List('f'))))

The representations we introduced so far are bound to our implementation and
therefore well suited for automated processing, but their syntax is not very
user-friendly. Typing the terms by hand is cumbersome and error-prone. We can
define a more compact and "human-friendly" notation as follows: A graph is
represented by a string of terms of the type X or Y-Z separated by commas.
The standalone terms stand for isolated nodes, the Y-Z terms describe edges.
If an X appears as an endpoint of an edge, it is automatically defined as a
node. Our example could be written as:

[b-c, f-c, g-h, d, f-b, k-f, h-g]

We call this the human-friendly form. As the example shows, the list does not
have to be sorted and may even contain the same edge multiple times. Notice
the isolated node d.

When the edges of a graph are directed, we call them arcs. These are
represented by ordered pairs. Such a graph is called directed graph.
To represent a directed graph, the forms discussed above are slightly
modified. The example graph opposite is represented as follows:

graph-term form:

Digraph.term(List('r', 's', 't', 'u', 'v'),
             List(('s', 'r'), ('s', 'u'), ('u', 'r'), ('u', 's'), ('v', 'u')))

adjacency-list form:

Digraph.adjacent(List(('r', Nil), ('s', List('r', 'u')), ('t', Nil),
                      ('u', List('r', 's')), ('v', List('u'))))

(Note that the adjacency-list form is the same for graphs and digraphs.)

human-friendly form:

[s>r, t, u>r, s>u, u>s, v>u]

Finally, graphs and digraphs may have additional information attached to nodes
and edges (arcs). For the nodes, this is no problem, as we can put any type
into them. On the other hand, for edges we have to extend our notation. Graphs
with additional information attached to edges are called labeled graphs.

graph-term form:

Digraph.termLabel(List('k', 'm', 'p', 'q'),
                  List(('m', 'q', 7), ('p', 'm', 5), ('p', 'q', 9)))

adjacency-list form:

Digraph.adjacentLabel(
  List(('k', Nil), ('m', List(('q', 7))), ('p', List(('m', 5), ('q', 9))),
       ('q', Nil)))
human-friendly form:

[p>q/9, m>q/7, k, p>m/5]

The notation for labeled graphs can also be used for so-called multi-graphs,
where more than one edge (or arc) is allowed between two given nodes.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p80"/>[P80](#p80) (\*\*\*) Conversions.
Write methods to generate the graph-term and adjacency-list forms from a Graph.
 Write another method to output the human-friendly form for a graph. Make it
 the toString method for Graph. Write more functions to create graphs from
 strings.

_Hint:_ You might need separate functions for labeled and unlabeled graphs.

scala> Graph.fromString("[b-c, f-c, g-h, d, f-b, k-f, h-g]").toTermForm
res0: (List[String], List[(String, String, Unit)]) = (List(d, k, h, c, f, g, b),List((h,g,()), (k,f,()), (f,b,()), (g,h,()), (f,c,()), (b,c,())))

scala> Digraph.fromStringLabel("[p>q/9, m>q/7, k, p>m/5]").toAdjacentForm
res1: List[(String, List[(String, Int)])] = List((m,List((q,7))), (p,List((m,5), (q,9))), (k,List()), (q,List()))

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p81"/>[P81](#p81) (\*\*) Path from one node to another one.
Write a method named findPaths to find acyclic paths from one node to another
in a graph. The method should return all paths.

scala> Digraph.fromStringLabel("[p>q/9, m>q/7, k, p>m/5]").findPaths("p", "q")
res0: List[List[String]] = List(List(p, q), List(p, m, q))

scala> Digraph.fromStringLabel("[p>q/9, m>q/7, k, p>m/5]").findPaths("p", "k")
res1: List[List[String]] = List()

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p82"/>[P82](#p82) (\*) Cycle from a given node.
Write a method named findCycles to find closed paths (cycles) starting at a
given node in a graph. The method should return all cycles.

scala> Graph.fromString("[b-c, f-c, g-h, d, f-b, k-f, h-g]").findCycles("f")
res0: List[List[String]] = List(List(f, c, b, f), List(f, b, c, f))

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p83"/>[P83](#p83) (\*\*) Construct all spanning trees.
Write a method spanningTrees to construct all spanning trees of a given graph.
With this method, find out how many spanning trees there are for the graph
depicted to the right. The data of this example graph can be found below. When
you have a correct solution for the spanningTrees method, use it to define two
other useful methods: isTree and isConnected. Both are five-minute tasks!

Graph:

        Graph.term(List('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'),
           List(('a', 'b'), ('a', 'd'), ('b', 'c'), ('b', 'e'),
                ('c', 'e'), ('d', 'e'), ('d', 'f'), ('d', 'g'),
                ('e', 'h'), ('f', 'g'), ('g', 'h')))

scala> Graph.fromString("[a-b, b-c, a-c]").spanningTrees
res0: List[Graph[String,Unit]] = List([a-b, b-c], [a-c, b-c], [a-b, a-c])

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p84"/>[P84](#p84) (\*\*) Construct the minimal spanning tree.
Write a method minimalSpanningTree to construct the minimal spanning tree of a
given labeled graph.

_Hint:_ Use Prim's Algorithm. A small modification of the
solution of [P83](#p83) does the trick. The data of the example graph to the right can
be found below.

Graph:

    Graph.termLabel(
        List('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'),
        List(('a', 'b', 5), ('a', 'd', 3), ('b', 'c', 2), ('b', 'e', 4),
            ('c', 'e', 6), ('d', 'e', 7), ('d', 'f', 4), ('d', 'g', 3),
            ('e', 'h', 5), ('f', 'g', 4), ('g', 'h', 1)))

scala> Graph.fromStringLabel("[a-b/1, b-c/2, a-c/3]").minimalSpanningTree
res0: Graph[String,Int] = [a-b/1, b-c/2]

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p85"/>[P85](#p85) (\*\*) Graph isomorphism.
Two graphs G1(N1,E1) and G2(N2,E2) are isomorphic if there is a bijection f:
N1 â†’ N2 such that for any nodes X,Y of N1, X and Y are adjacent if and only
if f(X) and f(Y) are adjacent.
Write a method that determines whether two graphs are isomorphic.

scala> Graph.fromString("[a-b]").isIsomorphicTo(Graph.fromString("[5-7]"))
res0: Boolean = true

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p86"/>[P86](#p86) (\*\*) Node degree and graph coloration.
a) Write a method Node.degree that determines the degree of a given node.

scala> Graph.fromString("[a-b, b-c, a-c, a-d]").nodes("a").degree
res0: Int = 3

b) Write a method that lists all nodes of a graph sorted according to
decreasing degree.

scala> Graph.fromString("[a-b, b-c, a-c, a-d]").nodesByDegree
res1: List[Graph[String,Unit]#Node] = List(Node(a), Node(c), Node(b), Node(d))

c) Use Welsh-Powell's algorithm to paint the nodes of a graph in such a way
that adjacent nodes have different colors. Make a method colorNodes that
returns a list of tuples, each of which contains a node and an integer
representing its color.

scala> Graph.fromString("[a-b, b-c, a-c, a-d]").colorNodes
res2: List[(Graph[String,Unit]#Node,Int)] = List((Node(a),1), (Node(b),2), (Node(c), 3), (Node(d), 2))

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p87"/>[P87](#p87) (\*\*) Depth-first order graph traversal.
Write a method that generates a depth-first order graph traversal sequence.
The starting point should be specified, and the output should be a list of
nodes that are reachable from this starting point (in depth-first order).

scala> Graph.fromString("[a-b, b-c, e, a-c, a-d]").nodesByDepthFrom("d")
res0: List[String] = List(c, b, a, d)

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p88"/>[P88](#p88) (\*\*) Connected components.
Write a function that splits a graph into its connected components.

scala> Graph.fromString("[a-b, c]").splitGraph
res0: List[Graph[String,Unit]] = List([a-b], [c])

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)


### <a name="p89"/>[P89](#p89) (\*\*) Bipartite graphs.
Write a function that determines whether a given graph is bipartite.

scala> Digraph.fromString("[a>b, c>a, d>b]").isBipartite
res0: Boolean = true

scala> Graph.fromString("[a-b, b-c, c-a]").isBipartite
res1: Boolean = false

scala> Graph.fromString("[a-b, b-c, d]").isBipartite
res2: Boolean = true

scala> Graph.fromString("[a-b, b-c, d, e-f, f-g, g-e, h]").isBipartite
res3: Boolean = false

The complete source file for this section is graph.scala.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)


* * *

## <a name="miscellaneous"/> [Section 7:](#miscellaneous) Miscellaneous Problems

### <a name="p90"/>[P90](#p90) (\*\*) Eight queens problem
This is a classical problem in computer science. The objective is to place
eight queens on a chessboard so that no two queens are attacking each other;
i.e., no two queens are in the same row, the same column, or on the same
diagonal.

_Hint:_ Represent the positions of the queens as a list of numbers 1..N. Example:
List(4, 2, 7, 3, 6, 8, 5, 1) means that the queen in the first column is in row
4, the queen in the second column is in row 2, etc. Use the generate-and-test
paradigm.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p91"/>[P91](#p91) (\*\*) Knight's tour.
Another famous problem is this one: How can a knight jump on an NÃ—N chessboard
in such a way that it visits every square exactly once?
Hints: Represent the squares by pairs of their coordinates of the form (X, Y),
where both X and Y are integers between 1 and N. (Alternately, define a Point
    class for the same purpose.) Write a function jumps(N, (X, Y)) to list the
    squares that a knight can jump to from (X, Y) on a NÃ—N chessboard. And
    finally, represent the solution of our
problem as a list of knight positions (the knight's tour).

It might be nice to find more than one tour, but a computer will take a long
time trying to find them all at once. Can you make a lazy list that only
calculates the tours as needed?

Can you find only "closed tours", where the knight can jump from its final
position back to its starting position?

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p92"/>[P92](#p92) (\*\*\*) Von Koch's conjecture.
Several years ago I met a mathematician who was intrigued by a problem for
which he didn't know a solution. His name was Von Koch, and I don't know
whether the problem has been solved since. [The "I" here refers to the author
of the Prolog problems. <PMG>]


Anyway the puzzle goes like this: Given a tree with N nodes (and hence N-1
    edges), find a way to enumerate the nodes from 1 to N and, accordingly,
    the edges from 1 to N-1 in such a way, that for each edge K the
    difference of its node numbers is equal to K. The conjecture is that
    this is always possible.

For small trees the problem is easy to solve by hand. However, for larger
trees, and 14 is already very large, it is extremely difficult to find a
solution. And remember, we don't know for sure whether there is always a
solution!

Write a function that calculates a numbering scheme for a given tree.
What is the solution for the larger tree pictured below?

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p93"/>[P93](#p93) (\*\*\*) An arithmetic puzzle.
Given a list of integer numbers, find a correct way of inserting arithmetic
signs (operators) such that the result is a correct equation. Example: With
the list of numbers List(2,3,5,7,11) we can form the equations 2-3+5+7 = 11
or 2 = (3*5+7)/11 (and ten others!).

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p94"/>[P94](#p94) (\*\*\*) Generate K-regular simple graphs with N nodes.
In a K-regular graph all nodes have a degree of K; i.e. the number of edges
incident in each node is K. How many (non-isomorphic!) 3-regular graphs with
6 nodes are there? See also a table of results and a Java applet that can
represent graphs geometrically.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p95"/>[P95](#p95) (\*\*) English number words.
On financial documents, like checks, numbers must sometimes be written in full
words. Example: 175 must be written as one-seven-five. Write a function
fullWords(num: Int) to print (non-negative) integer numbers in full words.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p96"/>[P96](#p96) (\*\*) Syntax checker.
In a certain programming language (Ada) identifiers are defined by the syntax
diagram (railroad chart) opposite. Transform the syntax diagram into a system
of syntax diagrams which do not contain loops; i.e. which are purely recursive.
Using these modified diagrams, write a function isIdentifier that can check
whether or not a given string is a legal identifier.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p97"/>[P97](#p97) (\*\*) Sudoku.
Sudoku puzzles go like this:

   Problem statement                 Solution

    .  .  4 | 8  .  . | .  1  7      9  3  4 | 8  2  5 | 6  1  7	     
            |         |                      |         |
    6  7  . | 9  .  . | .  .  .      6  7  2 | 9  1  4 | 8  5  3
            |         |                      |         |
    5  .  8 | .  3  . | .  .  4      5  1  8 | 6  3  7 | 9  2  4
    --------+---------+--------      --------+---------+--------
    3  .  . | 7  4  . | 1  .  .      3  2  5 | 7  4  8 | 1  6  9
            |         |                      |         |
    .  6  9 | .  .  . | 7  8  .      4  6  9 | 1  5  3 | 7  8  2
            |         |                      |         |
    .  .  1 | .  6  9 | .  .  5      7  8  1 | 2  6  9 | 4  3  5
    --------+---------+--------      --------+---------+--------
    1  .  . | .  8  . | 3  .  6      1  9  7 | 5  8  2 | 3  4  6
            |         |                      |         |
    .  .  . | .  .  6 | .  9  1      8  5  3 | 4  7  6 | 2  9  1
            |         |                      |         |
    2  4  . | .  .  1 | 5  .  .      2  4  6 | 3  9  1 | 5  7  8


Every spot in the puzzle belongs to a (horizontal) row and a (vertical)
column, as well as to one single 3Ã—3 square (which we call "square" for
short). At the beginning, some of the spots carry a single-digit number
between 1 and 9. The problem is to fill the missing spots with digits in
such a way that every number between 1 and 9 appears exactly once in each
row, in each column, and in each square.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p98"/>[P98](#p98) (\*\*\*) Nonograms.
Around 1994, a certain kind of puzzles was very popular in England. The
"Sunday Telegraph" newspaper wrote: "Nonograms are puzzles from Japan and are
currently published each week only in The Sunday Telegraph. Simply use your
logic and skill to complete the grid and reveal a picture or diagram." As a
programmer, you are in a better situation:
you can have your computer do the work! Just write a little program ;-).
The puzzle goes like this: Essentially, each row and column of a rectangular
bitmap is annotated with the respective lengths of its distinct strings of
occupied cells. The person who solves the puzzle must complete the bitmap
given only these lengths.

~~~
  Problem statement:          Solution:

  |_|_|_|_|_|_|_|_| 3         |_|X|X|X|_|_|_|_| 3           
  |_|_|_|_|_|_|_|_| 2 1       |X|X|_|X|_|_|_|_| 2 1         
  |_|_|_|_|_|_|_|_| 3 2       |_|X|X|X|_|_|X|X| 3 2         
  |_|_|_|_|_|_|_|_| 2 2       |_|_|X|X|_|_|X|X| 2 2         
  |_|_|_|_|_|_|_|_| 6         |_|_|X|X|X|X|X|X| 6           
  |_|_|_|_|_|_|_|_| 1 5       |X|_|X|X|X|X|X|_| 1 5         
  |_|_|_|_|_|_|_|_| 6         |X|X|X|X|X|X|_|_| 6           
  |_|_|_|_|_|_|_|_| 1         |_|_|_|_|X|_|_|_| 1           
  |_|_|_|_|_|_|_|_| 2         |_|_|_|X|X|_|_|_| 2           
   1 3 1 7 5 3 4 3             1 3 1 7 5 3 4 3              
   2 1 5 1                     2 1 5 1                      
~~~

For the example above, the problem can be stated as the two lists
[[3],[2,1],[3,2],[2,2],[6],[1,5],[6],[1],[2]] and
[[1,2],[3,1],[1,5],[7,1],[5],[3],[4],[3]] which give the "solid" lengths of
the rows and columns, top-to-bottom and left-to-right, respectively.
Published puzzles are larger than this example, e.g. 25Ã—20, and apparently
always have unique solutions.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)

### <a name="p99"/>[P99](#p99) (\*\*\*) Crossword puzzle.
Given an empty (or almost empty) framework of a crossword puzzle and a set of
words. The problem is to place the words into the framework.
The particular crossword puzzle is specified in a text file which first lists
the words (one word per line) in an arbitrary order. Then, after an empty line,
the crossword framework is defined. In this framework specification, an empty
character location is represented by a dot `.`. In order to make the solution
easier, character locations can also contain predefined character values.
The puzzle opposite is defined in the file p99a.dat, other examples are
p99b.dat and p99d.dat. There is also an example of a puzzle (p99c.dat)
which does not have a solution.

Words are strings of at least two characters. A horizontal or vertical
sequence of character places in the crossword puzzle framework is called
a site. Our problem is to find a compatible way of placing words onto sites.

Hints:

(1) The problem is not easy. You will need some time to thoroughly
understand it. So, don't give up too early! And remember that the objective
is a clean solution, not just a quick-and-dirty hack!

(2) For efficiency reasons it is important, at least for larger puzzles, to
sort the words and the sites in a particular order. For this part of the
problem, the solution of P28 may be very helpful.

![Incomplete](http://www.pcc.edu/enroll/paying-for-college/financial-aid/images/flag.png)
