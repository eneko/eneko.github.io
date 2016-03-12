//
//  Arithmetic.swift
//  NinetyNineSwiftProblems
//
//  Created by Eneko Alonso on 3/10/16.
//  Copyright © 2016 Eneko. All rights reserved.
//

import Foundation

extension Int {
    // P31 (**) Determine whether a given integer number is prime.
    func isPrime() -> Bool {
        if self < 4 {
            return true
        }
        let root = Int(sqrt(Double(self)))
        for i in 2...root {
            if self % i == 0 {
                return false
            }
        }
        return true
    }
}
