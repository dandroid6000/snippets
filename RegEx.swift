//
//  RegExMatchOperator.swift
//  RegExMatchOperator
//
//  Created by Dan Kane on 1/18/16.
//  Copyright © 2016 Dan Kane. All rights reserved.
//

struct RegEx {
    var pattern: String? {
        return self.matcher?.pattern
    }
    
    var options: NSRegularExpressionOptions? {
        return self.matcher?.options
    }
    
    private let matcher: NSRegularExpression?
    
    init(pattern: String, options: NSRegularExpressionOptions = []) {
        self.matcher = try? NSRegularExpression(pattern: pattern, options: options)
    }
    
    func match(string: String, options: NSMatchingOptions = []) -> Bool {
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
        self.init(pattern: "\(value)", options: [])
    }
    
    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(pattern: value, options: [])
    }
    
    init(stringLiteral value: StringLiteralType) {
        self.init(pattern: value, options: [])
    }
}

infix operator =~ {}
func =~ (target: String, var pattern: RegEx) -> Bool {
    return pattern.match(target)
}
