/*: 
# Ninety-Nine Swift Problems
Ninety-Nine Swift Problems is an adaptation of the
[Ninety-Nine Scala Problems](http://aperiodic.net/phil/scala/s-99/) written by
[Phil Gold](http://aperiodic.net/phil/), which in turn was an adaptation of the
original [Ninety-Nine Prolog Problems](https://prof.ti.bfh.ch/hew1/informatik3/prolog/p-99/)
written by Werner Hett at Berne University of Applied Sciences in Berne, Switzerland.
I (Eneko Alonso) have written this adaptation to Swift.

From the 99 Scala Problems:

_The problems have different levels of difficulty. Those marked with a single
asterisk (\*) are easy. If you have successfully solved the preceding problems
you should be able to solve them within a few (say 15) minutes. Problems marked
with two asterisks (\*\*) are of intermediate difficulty. If you are a skilled
Scala programmer it shouldn't take you more than 30-90 minutes to solve them.
Problems marked with three asterisks (\*\*\*) are more difficult. You may need
more time (i.e. a few hours or more) to find a good solution. The difficulties
were all assigned for the Prolog problems, but the Scala versions seem to be
of roughly similar difficulty._

_Your goal should be to find the most elegant solution of the given problems.
Efficiency is important, but clarity is even more crucial. Some of the (easy)
problems can be trivially solved using built-in functions. However, in these
cases, you learn more if you try to find your own solution._

Most of the above also applies to Swift, since both Swift and Scala are high-level
modern languages.

For more information, see [Ninety-Nine Swift Problems](http://enekoalonso.com/99-swift-problems)
 */

/*: 
  ## Working with Linked Lists
*/


List<String>()
List(1, 1, 2, 3, 5, 8)


//: ### P01 (\*) Find the last element of a list.
List(1, 1, 2, 3, 5, 8).last
List(1).last

//: ### P02 (\*) Find the last but one element of a list.
List(1, 1, 2, 3, 5, 8).pennultimate
List(1, 1).pennultimate
List(1).pennultimate

//: ### P03 (\*) Find the Kth element of a list.
//: By convention, the first element in the list is element `0`.
List(1, 1, 2, 3, 5, 8).elementAtIndex(2)
List(1, 1, 2, 3, 5, 8).elementAtIndex(0)
List(1, 1, 2, 3, 5, 8).elementAtIndex(10)
List(1).elementAtIndex(1)

//: ### P04 (\*) Find the number of elements of a list.
List(1, 1, 2, 3, 5, 8).length
List(1).length

//: ### P05 (\*) Reverse a list.
List(1, 1, 2, 3, 5, 8).reverse()
List(1, 1, 2, 1, 1).reverse()
List(1).reverse()

//: ### P06 (\*) Find out whether a list is a palindrome.
List(1, 1, 2, 3, 5, 8).isPalindrome()
List(1, 1, 2, 1, 1).isPalindrome()
List(1).isPalindrome()


//: ### P07 (\*\*) Flatten a nested list structure.
List<Any>(List<Any>(1, 1), 2, List<Any>(3, List<Any>(5, 8))).flatten()
List(1, 1, 2, 3, 5, 8).flatten()
List<Any>(List<Any>(List<Any>(List<Any>(List<Any>(1), List<Any>(2), List<Any>(3, 4))))).flatten()

//: ### P08 (\*\*) Eliminate consecutive duplicates of list elements.
//: If a list contains repeated elements they should be replaced with a single copy
//: of the element. The order of the elements should not be changed.
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e").compress()
List(1, 1, 2, 3, 5, 8).compress()
List("a").compress()

//: ### P09 (\*\*) Pack consecutive duplicates of list elements into sublists.
//: If a list contains repeated elements they should be placed in separate sublists.
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e").pack()
List(1, 1, 2, 3, 5, 8).pack()
List("a").pack()

//: ### P10 (\*) Run-length encoding of a list.
//: Use the result of problem P09 to implement the so-called run-length encoding
//: data compression method. Consecutive duplicates of elements are encoded as
//: tuples `(N, E)` where `N` is the number of duplicates of the element `E`.
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e").encode()
List(1, 1, 2, 3, 5, 8).encode()
List("a").encode()

//: ### P11 (\*) Modified run-length encoding.
//: Modify the result of problem P10 in such a way that if an element has no
//: duplicates it is simply copied into the result list. Only elements with
//: duplicates are transferred as `(N, E)` terms.
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e").encodeModified()
List(1, 1, 2, 3, 5, 8).encodeModified()
List("a").encodeModified()

//: ### P12 (\*\*) Decode a run-length encoded list.
//: Given a run-length code list generated as specified in problem [P10](#p10),
//: construct its uncompressed version.
List((4, "a"), (1, "b"), (2, "c"), (2, "a"), (1, "d"), (4, "e")).decode()

//: ### P13 (\*\*) Run-length encoding of a list (direct solution).
//: Implement the so-called run-length encoding data compression method directly.
//: I.e. don't use other methods you've written (like P09's pack); do all
//: the work directly.
List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e").encodeDirect()
List(1, 1, 2, 3, 5, 8).encodeDirect()
List("a").encodeDirect()

//: ### P14 (\*) Duplicate the elements of a list.
List("a", "b", "c", "c", "d").duplicate()
List(1, 1, 2, 3, 5, 8).duplicate()
List("a").duplicate()

//: ### P15 (\*\*) Duplicate the elements of a list a given number of times.
List("a", "b", "c", "c", "d").duplicate(3)
List(1, 1, 2, 3, 5, 8).duplicate(3)
List("a").duplicate(9)

//: ### P16 (\*\*) Drop every Nth element from a list.
List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").drop(3)
List(1, 1, 2, 3, 5, 8).drop(3)
List("a").drop(3)
List(1, 1, 2, 3, 5, 8).drop(2)
List(1, 1, 2, 3, 5, 8).drop(1)
List(1, 1, 2, 3, 5, 8).drop(0)

//: ### P17 (\*) Split a list into two parts.
//: The length of the first part is given. Use a Tuple for your result.
List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").split(3).0
List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").split(3).1

List(1, 1, 2, 3, 5, 8).split(3).0
List(1, 1, 2, 3, 5, 8).split(3).1

List("a").split(3).0
List("a").split(3).1

List(1, 1, 2, 3, 5, 8).split(0).0
List(1, 1, 2, 3, 5, 8).split(0).1

//: ### P18 (\*\*) Extract a slice from a list.
//: Given two indices, `I` and `K`, the slice is the list containing the elements
//: from and including the `Ith` element up to but not including the `Kth` element
//: of the original list. Start counting the elements with `0`.
List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").slice(3, 7)
List(1, 1, 2, 3, 5, 8).slice(3, 7)
List("a").slice(3, 7)

//: ### P19 (\*\*) Rotate a list N places to the left.
List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").rotate(3)
List(1, 1, 2, 3, 5, 8).rotate(3)
List("a").rotate(3)

List("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k").rotate(-2)
List(1, 1, 2, 3, 5, 8).rotate(-2)
List("a").rotate(-2)

//: ### P20 (\*) Remove the Kth element from a list.
//: Return the list and the removed element in a Tuple. Elements are numbered from `0`.
List("a", "b", "c", "d").removeAt(1).0
List("a", "b", "c", "d").removeAt(1).1
List(1, 1, 2, 3, 5, 8).removeAt(1).0
List(1, 1, 2, 3, 5, 8).removeAt(1).1
List("a").removeAt(1).0
List("a").removeAt(1).1

//: ### P21 (\*) Insert an element at a given position into a list.
List("a", "b", "c", "d").insertAt(1, "new")
List(1, 1, 2, 3, 5, 8).insertAt(1, "new")
List("a").insertAt(1, "new")

//: ### P22 (\*) Create a list containing all integers within a given range.
List<Int>.range(4, 9)

//: ### P23 (\*\*) Extract a given number of randomly selected elements from a list.
//: Hint: Use the solution to problem P20
List("a", "b", "c", "d", "e", "f", "g", "h").randomSelect(3)
List(1, 1, 2, 3, 5, 8).randomSelect(3)
List("a").randomSelect(3)

//: ### P24 (\*) Lotto: Draw N different random numbers from the set 1..M.
List<Int>.lotto(6, 49)

//: ### P25 (\*) Generate a random permutation of the elements of a list.
//: Hint: Use the solution of problem P23.
List("a", "b", "c", "d", "e", "f").randomPermute()
List(1, 1, 2, 3, 5, 8).randomPermute()
List("a").randomPermute()

//: ### P26 (\*\*) Generate the combinations of K distinct objects chosen from the N elements of a list.
//: In how many ways can a committee of 3 be chosen from a group of 12 people?
//: We all know that there are `C(12,3) = 220` possibilities (`C(N,K)` denotes the well-known binomial coefficient). For pure mathematicians, this result may be great. But we want to really generate all the possibilities.
List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12).combinations(3)?.length
List("a", "b", "c", "d", "e", "f").combinations(3)?.length
List(1, 1, 2, 3, 5, 8).combinations(3)
List("a").combinations(3)
List("a", "b", "c").combinations(2)

//: ### P26B (\*\*) Generate the permutations of K distinct objects chosen from the N elements of a list.
//: In how many ways can 12 people sit on 3 chairs?
//: Generate all the possible permutations. Eg. `P(12,3) = 660`.
List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12).permutations(3)?.length
List("a", "b", "c", "d", "e", "f").permutations(3)?.length
List(1, 1, 2, 3, 5, 8).permutations(3)
List("a").permutations(3)
List("a", "b", "c").permutations(2)


/*

### <a name="p27"/>[P27](#p27) (\*\*) Group the elements of a set into disjoint subsets.
a) In how many ways can a group of 9 people work in 3 disjoint subgroups of
2, 3 and 4 persons? Write a function that generates all the possibilities.

Example:

~~~swift
let list = List("Aldo", "Beat", "Carla", "David", "Evi", "Flip", "Gary", "Hugo", "Ida")
print(list.group3()) // (((Aldo, Beat), (Carla, David, Evi), (Flip, Gary, Hugo, Ida)), ...
    ~~~

b) Generalize the above predicate in a way that we can specify a list of group
sizes and the predicate will return a list of groups.

Example:

~~~swift
let list = List("Aldo", "Beat", "Carla", "David", "Evi", "Flip", "Gary", "Hugo", "Ida")
print(list.group(List(2, 2, 5))) // (((Aldo, Beat), (Carla, David), (Evi, Flip, Gary, Hugo, Ida)), ...
    ~~~

Note that we do not want permutations of the group members;
i.e. ((Aldo, Beat), ...) is the same solution as ((Beat, Aldo), ...).
However, we make a difference between ((Aldo, Beat), (Carla, David), ...)
and ((Carla, David), (Aldo, Beat), ...).

You may find more about this combinatorial problem in a good book on discrete
mathematics under the term "multinomial coefficients".

### <a name="p28"/>[P28](#p28) (\*\*) Sorting a list of lists according to length of sublists.
a) We suppose that a list contains elements that are lists themselves.
The objective is to sort the elements of the list according to their length.
E.g. short lists first, longer lists later, or vice versa.

Example:

~~~swift
let list = List(List("a", "b", "c"), List("d", "e"), List("f", "g", "h"), List("d", "e"), List("i", "j", "k", "l"), List("m", "n"), List("o"))
print(list.lsort()) // (("o"), ("d", "e"), ("d", "e"), ("m", "n"), ("a", "b", "c"), ("f", "g", "h"), ("i", "j", "k", "l"))
    ~~~

b) Again, we suppose that a list contains elements that are lists themselves.
But this time the objective is to sort the elements according to their length
frequency; i.e. in the default, sorting is done ascendingly, lists with rare
lengths are placed, others with a more frequent length come later.

Example:

~~~swift
let list = List(List("a", "b", "c"), List("d", "e"), List("f", "g", "h"), List("d", "e"), List("i", "j", "k", "l"), List("m", "n"), List("o"))
print(list.lsortFreq()) // (("i", "j", "k", "l"), ("o"), ("a", "b", "c"), ("f", "g", "h"), ("d", "e"), ("d", "e"), ("m", "n"))
    ~~~

Note that in the above example, the first two lists in the result have length
4 and 1 and both lengths appear just once. The third and fourth lists have
length 3 and there are two list of this length. Finally, the last three lists
have length 2. This is the most frequent length.


*/

func and(a: Bool, _ b: Bool) -> Bool {
    return a && b
}

func or(a: Bool, _ b: Bool) -> Bool {
    return a || b
}

infix operator ∧ { associativity left precedence 140 }
func ∧ (a: Bool, b: Bool) -> Bool {
    return a && b
}


func table(expression: (a: Bool, b: Bool) -> Bool) {
    print("A\tB\tResult")
    print(String(format: "%d\t%d\t%d", Int(false), Int(false), Int(expression(a: false, b: false))))
    print(String(format: "%d\t%d\t%d", Int(false), Int(true), Int(expression(a: false, b: true))))
    print(String(format: "%d\t%d\t%d", Int(true), Int(false), Int(expression(a: true, b: false))))
    print(String(format: "%d\t%d\t%d", Int(true), Int(true), Int(expression(a: true, b: true))))
}

table({ $0 ∧ $1 })
table({ and($0, and($0, $1)) })
table({ or(or($0, $1), and(and($0, and($0, $1)), $1)) })



func table2(expression: (a: [Bool]) -> Bool) {
    print("A\tB\tResult")
//    print(String(format: "%d\t%d\t%d", Int(false), Int(false), Int(expression(a: [false, false]))))
//    print(String(format: "%d\t%d\t%d", Int(false), Int(true), Int(expression(a: false, b: true))))
//    print(String(format: "%d\t%d\t%d", Int(true), Int(false), Int(expression(a: true, b: false))))
//    print(String(format: "%d\t%d\t%d", Int(true), Int(true), Int(expression(a: true, b: true))))
}

//table2({ vars in vars[0] ||| vars[1] })



Tree("a", Tree("b", nil, nil), nil)

Tree("a", Tree("b", Tree("d"), Tree("e")), Tree("c", nil, Tree("f", Tree("g"), nil)))


Tree("a", Tree("b", nil, Tree("c")))


Tree<String>.cBalanced(4, "x")

Tree(1, Tree(2), Tree(3))



var a: Int?
a? = 5
a


