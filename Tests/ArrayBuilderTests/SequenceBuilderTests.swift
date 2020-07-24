//
//  SequenceBuilderTests.swift
//  
//
//  Created by Tielmann, Andreas on 24.07.2020.
//

@testable import ArrayBuilder
import XCTest

final class SequenceBuilderTests: XCTestCase {

    func test(@SequenceBuilder<String> builder: () -> AnySequence<String>) -> [String] {
        Array(builder())
    }

    func createMaybeString() -> String? {
        "createMaybeString"
    }

    func createStringArray() -> [String] {
        ["createStringArray1", "createStringArray2"]
    }

    func testExample() {
        let x = 42

        let result = test {
            createMaybeString()
            createStringArray()
            if x > 2 {
                "x>2"
            } else {
                "x<=2"
            }
            if x <= 2 {
                "x<=2"
            } else {
                "x>2"
            }
            test {
                ["hello", "world"]
                [["hello", "world"]]
                Optional("optional?")
                Optional(nil)
                Optional(4).map(String.init)
                ["l", "o", "o", "o", "n", "g"].prefix(3)
            }
            do {
                "hello"
            }
            "always"
        }

        let expected = [
            "createMaybeString",
            "createStringArray1", "createStringArray2",
            "x>2",
            "x>2",
            "hello", "world",
            "hello", "world",
            "optional?",
            "4",
            "l", "o", "o",
            "hello",
            "always"
        ]

        XCTAssertEqual(result, expected)
    }

    func testComment() {
        func list(@SequenceBuilder<String> builder: () -> AnySequence<String>) -> [String] {
            Array(builder())
        }

        let result = list {
            "some string"
            if sqrt(16) > 2 {
                "foo"
            } else {
                "bar"
            }
        }

        XCTAssertEqual(result, ["some string", "foo"])
    }

    static var allTests = [
        ("testExample", testExample),
        ("testComment", testComment)
    ]
}
