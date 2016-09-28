import XCTest
@testable import Perfect_Blog_Mustache

class Perfect_Blog_MustacheTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Perfect_Blog_Mustache().text, "Hello, World!")
    }


    static var allTests : [(String, (Perfect_Blog_MustacheTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
