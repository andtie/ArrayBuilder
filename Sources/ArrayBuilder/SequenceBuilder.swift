//
//  SequenceBuilder.swift
//  
//
//  Created by Tielmann, Andreas on 24.07.2020.
//

/** a generic sequence builder
   ```swift
   func list(@SequenceBuilder<String> builder: () -> AnySequence<String>) -> [String] {
       Array(builder())
   }

   list {
       "some string"
       if sqrt(16) > 2 {
           "foo"
       } else {
           "bar"
       }
   }

   // returns ["some string", "foo"]
   ```
*/
@_functionBuilder public enum SequenceBuilder<T> {

    public typealias Result = AnySequence<T>

    /// combines multiple partial results into one.
    public static func buildBlock(_ parts: Result...) -> Result {
        AnySequence(parts.flatMap { $0 })
    }

    /// same as buildBlock(), but for the do clause.
    public static func buildDo(_ parts: Result...) -> Result {
        AnySequence(parts.flatMap { $0 })
    }

    /// create partial results from the result of either of two optionally-executed sub-blocks. You must implement both of the methods and they must be the inverse of each other.
    public static func buildEither(first: Result) -> Result {
        first
    }

    /// create partial results from the result of either of two optionally-executed sub-blocks. You must implement both of the methods and they must be the inverse of each other.
    public static func buildEither(second: Result) -> Result {
        second
    }

    /// creates a partial result from the result of an optionally-executed sub-block.
    public static func buildOptional(_ part: Result?) -> Result {
        part ?? AnySequence([])
    }

    // MARK: - Expressions

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: T) -> Result {
        AnySequence([expression])
    }

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: T?) -> Result {
        expression.map { AnySequence([$0]) } ?? AnySequence([])
    }

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: Result) -> Result {
        expression
    }

    /// creates a partial result from a single expression.
    public static func buildExpression<S1: Sequence, S2: Sequence>(_ expression: S1) -> Result where S1.Element == S2, S2.Element == T {
        AnySequence(expression.flatMap { $0 })
    }

    /// creates a partial result from a single expression.
    public static func buildExpression<S: Sequence>(_ expression: S) -> Result where S.Element == T {
        AnySequence(expression)
    }
}
