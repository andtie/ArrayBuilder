import XCTest

import ArrayBuilderTests

var tests = [XCTestCaseEntry]()
tests += ArrayBuilderTests.allTests()
tests += SequenceBuilderTests.allTests()
XCTMain(tests)
