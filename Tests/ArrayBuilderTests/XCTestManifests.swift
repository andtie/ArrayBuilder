import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(ArrayBuilderTests.allTests),
        testCase(SequenceBuilderTests.allTests)
    ]
}
#endif
