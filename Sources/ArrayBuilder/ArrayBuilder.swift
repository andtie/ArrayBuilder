//import Foundation

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
    public static func buildExpression(_ expression: [[T]]) -> [T] {
        expression.flatMap { $0 }
    }

    /// creates a partial result from a single expression.
    public static func buildExpression<S: Sequence>(_ expression: S) -> [T] where S.Element == T {
        Array(expression)
    }
}