//
//  RegExMatchOperator.swift
//  RegExMatchOperator
//
//  Created by Dan Kane on 1/18/16.
//  Copyright © 2016 Dan Kane. All rights reserved.
//

struct RegEx {
    let pattern: String
    let options: NSRegularExpressionOptions
    
    private lazy var matcher: NSRegularExpression? = try? NSRegularExpression(pattern: self.pattern, options: self.options)
    
    init(pattern: String, options: NSRegularExpressionOptions = []) {
        self.pattern = pattern
        self.options = options
    }
    
    mutating func match(string: String, options: NSMatchingOptions = []) -> Bool {
        if let matcher = self.matcher {
            return matcher.numberOfMatchesInString(string, options: options, range: NSMakeRange(0, string.characters.count)) > 0
        }
        return false
    }
}

extension RegEx: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias UnicodeScalarLiteralType = StringLiteralType

    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.pattern = "\(value)"
        self.options = []
    }
    
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.pattern = value
        self.options = []
    }
    
    init(stringLiteral value: StringLiteralType) {
        self.pattern = value
        self.options = []
    }
}

infix operator =~ {}
func =~ (target: String, var pattern: RegEx) -> Bool {
    return pattern.match(target)
}
