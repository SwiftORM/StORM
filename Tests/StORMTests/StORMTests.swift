import XCTest
import PerfectLib
@testable import StORM


class StORMTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}

	func refDate() -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd"
		return formatter.date(from: "2007/03/01")!
	}
	func refDate2() -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd"
		return formatter.date(from: "2007/03/02")!
	}

	// =======================================================================================
	// String Tests
	// =======================================================================================
	func testExtractString() {
		let data = ["name": "baseDomain", "val": "localhost"]
		XCTAssert(StORM.Extract.string(data, "name") == "baseDomain")
		XCTAssert(StORM.Extract.string(data, "val") == "localhost")
	}

	func testExtractStringDefaultNotUsed() {
		let data = ["name": "baseDomain", "val": "localhost"]
		XCTAssert(StORM.Extract.string(data, "name", "kong") == "baseDomain")
	}

	func testExtractStringDefaultUsed() {
		let data = ["name": "baseDomain", "val": "localhost"]
		XCTAssert(StORM.Extract.string(data, "donkey", "kong") == "kong")
	}

	func testExtractStringNil() {
		let data = ["name": "baseDomain", "val": "localhost"]
		XCTAssert(StORM.Extract.string(data, "donkey", nil) == nil)
	}


	// =======================================================================================
	// Int Tests
	// =======================================================================================
	func testExtractInt() {
		let data = ["name": "baseDomain", "intTest": 123, "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.int(data, "intTest") == 123)
	}

	func testExtractIntDefaultNotUsed() {
		let data = ["name": "baseDomain", "intTest": 123, "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.int(data, "intTest", 555) == 123)
	}

	func testExtractIntDefaultUsed() {
		let data = ["name": "baseDomain", "intTest": 123, "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.int(data, "donkey", 777) == 777)
	}

	func testExtractIntNil() {
		let data = ["name": "baseDomain", "intTest": 123, "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.int(data, "donkey", nil) == nil)
	}



	// =======================================================================================
	// Date Tests
	// =======================================================================================
	func testExtractDate() {
		let data = ["name": "baseDomain", "test": "2007/03/01", "val": "localhost"] as [String : Any]
		let result = StORM.Extract.date(data, "test")!

		XCTAssert(result == refDate())
	}

	func testExtractDateDefaultNotUsed() {
		let data = ["name": "baseDomain", "test": "2007/03/01", "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.date(data, "test", refDate2()) == refDate())
	}

	func testExtractDateDefaultUsed() {
		let data = ["name": "baseDomain", "test": "2007/03/01", "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.date(data, "donkey", refDate()) == refDate())
	}

	func testExtractDateNil() {
		let data = ["name": "baseDomain", "test": "2007/03/01", "val": "localhost"] as [String : Any]
		XCTAssert(StORM.Extract.date(data, "donkey", nil) == nil)
	}


	// TODO: Double
	// TODO: Bool
	// TODO: Bytes / UInt8 array
	// TODO: Array Of Strings
	// TODO: Array Of Integers
	// TODO: Array Of Any
	// TODO: Return a JSON-type map [String:Any]





	static var allTests : [(String, (StORMTests) -> () throws -> Void)] {
		return [
			("testExtractString", testExtractString),
			("testExtractStringDefaultNotUsed",testExtractStringDefaultNotUsed),
			("testExtractStringDefaultUsed",testExtractStringDefaultUsed),
			("testExtractStringNil",testExtractStringNil),

			("testExtractInt", testExtractInt),
			("testExtractIntDefaultNotUsed",testExtractIntDefaultNotUsed),
			("testExtractIntDefaultUsed",testExtractIntDefaultUsed),
			("testExtractIntNil",testExtractIntNil),

			("testExtractDate", testExtractDate),
			("testExtractDateDefaultNotUsed",testExtractDateDefaultNotUsed),
			("testExtractDateDefaultUsed",testExtractDateDefaultUsed),
			("testExtractDateNil",testExtractDateNil),

		]
	}

}
