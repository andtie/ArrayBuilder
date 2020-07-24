//
//  ArrayBuilder.swift
//
//
//  Created by Tielmann, Andreas on 24.07.2020.
//

/** a generic array builder
    ```swift
    func list(@ArrayBuilder<String> builder: () -> [String]) -> [String] {
        builder()
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
@_functionBuilder public enum ArrayBuilder<T> {

    /// combines multiple partial results into one.
    public static func buildBlock(_ parts: [T]...) -> [T] {
        parts.flatMap { $0 }
    }

    /// same as buildBlock(), but for the do clause.
    public static func buildDo(_ parts: [T]...) -> [T] {
        parts.flatMap { $0 }
    }

    /// create partial results from the result of either of two optionally-executed sub-blocks. You must implement both of the methods and they must be the inverse of each other.
    public static func buildEither(first: [T]) -> [T] {
        first
    }

    /// create partial results from the result of either of two optionally-executed sub-blocks. You must implement both of the methods and they must be the inverse of each other.
    public static func buildEither(second: [T]) -> [T] {
        second
    }

    /// creates a partial result from the result of an optionally-executed sub-block.
    public static func buildOptional(_ part: [T]?) -> [T] {
        part ?? []
    }

    // MARK: - Expressions

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: T) -> [T] {
        [expression]
    }

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: T?) -> [T] {
        expression.map { [$0] } ?? []
    }

    /// creates a partial result from a single expression.
    public static func buildExpression(_ expression: [T]) -> [T] {
        expression
    }

    /// creates a partial result from a single expression.
    public static func buildExpression<S1: Sequence, S2: Sequence>(_ expression: S1) -> [T] where S1.Element == S2, S2.Element == T {
        Array(expression.flatMap { $0 })
    }

    /// creates a partial result from a single expression.
    public static func buildExpression<S: Sequence>(_ expression: S) -> [T] where S.Element == T {
        Array(expression)
    }
}
