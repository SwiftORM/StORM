import XCTest
import PerfectLib
@testable import StORM




class StORMTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
    
    func testKeyTypeIntegerNil() {
        
        let val : Int? = nil
        
        // Grab the type of value:
        let type = type(of: val)
        // Check if we are nil, we would then of course have an empty primary key.
        
        switch type {
        case is Int.Type, is Int?.Type:
            guard String(describing: val) != "nil" else {
                XCTAssert(true)
                return
            }
            XCTFail("Value was supposed to be nil.")
           // return (val as! Int == 0)
        case is String.Type, is String?.Type:
         //   return (val as! String).isEmpty
            XCTFail("Type was supposed to be an integer.")
        default:
            XCTFail("Type should either be a String or Integer.")
            print("[StORM] WARNING: Unexpected type for PRIMARY KEY in function: \(#function). TYPE: \(type)")
       //     return false
        }
        
    }
    
    func testKeyTypeOptionalInteger() {
        
        
        let val : Int? = 1
        
        let anyVal : Any = val
        
        // Grab the type of value:
        let type = type(of: val)
        // Check if we are nil, we would then of course have an empty primary key.
        guard String(describing: anyVal) != "nil" else {
            XCTFail("Value was not supposed to be nil.")
            return
        }
        
        switch type {
        case is Int.Type, is Int?.Type:
            XCTAssert((anyVal as? Int) != nil, "Failed to cast optional Integer as Any to Int")
        // return (val as! Int == 0)
        case is String.Type, is String?.Type:
            //   return (val as! String).isEmpty
            XCTFail("Type was supposed to be an integer.")
        default:
            XCTFail("Type should either be a String or Integer.")
            print("[StORM] WARNING: Unexpected type for PRIMARY KEY in function: \(#function). TYPE: \(type)")
            //     return false
        }
        
    }
    
    func testKeyTypeStringNil() {
        
        let val : String? = nil
        
        // Grab the type of value:
        let type = type(of: val)
        
        switch type {
        case is Int.Type, is Int?.Type:
            XCTFail("Type was supposed to be a string.")
        case is String.Type, is String?.Type:
            guard String(describing: val) != "nil" else {
                XCTAssert(true)
                return
            }
            XCTFail("Value was supposed to be nil.")
        default:
            XCTFail("Type should either be a String or Integer.")
            print("[StORM] WARNING: Unexpected type for PRIMARY KEY in function: \(#function). TYPE: \(type)")
        }
        
    }
    
    func testKeyTypeOptionalString() {
        
        
        let val : String? = ""
        
        let anyVal : Any = val
        
        // Grab the type of value:
        let type = type(of: val)
        // Check if we are nil, we would then of course have an empty primary key.
        guard String(describing: anyVal) != "nil" else {
            XCTFail("Value was not supposed to be nil.")
            return
        }
        
        switch type {
        case is Int.Type, is Int?.Type:
            XCTFail("Type was supposed to be a string.")
        case is String.Type, is String?.Type:
            XCTAssert((anyVal as? String) != nil, "Failed to cast optional string as Any to String")
        default:
            XCTFail("Type should either be a String or Integer.")
            print("[StORM] WARNING: Unexpected type for PRIMARY KEY in function: \(#function). TYPE: \(type)")
        }
        
    }

	static var allTests : [(String, (StORMTests) -> () throws -> Void)] {
		return [
		]
	}

}
