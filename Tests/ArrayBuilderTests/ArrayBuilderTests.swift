@testable import ArrayBuilder
import XCTest

final class ArrayBuilderTests: XCTestCase {

    func test(@ArrayBuilder<String> builder: () -> [String]) -> [String] {
        builder()
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

    static var allTests = [
        ("testExample", testExample)
    ]
}
