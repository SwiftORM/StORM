//
//  StORM.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-30.
//
//

public var StORMdebug = false

open class StORM {

	open var results		= StORMResultSet()

	// connection error status
	open var error			= StORMError()

	// should contain last error message as string.
	open var errorMsg		= ""

	public init() {}

	// introspection of structure
	public func cols(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		var count = 0
		let mirror = Mirror(reflecting: self)
		for child in mirror.children {
			guard let key = child.label else {
				continue
			}
			if count >= offset && !key.hasPrefix("internal_") {
				c.append((key, type(of:child.value)))
				//c[key] = type(of:child.value)
			}
			count += 1
		}
		return c
	}

	public func asData(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		var count = 0
		let mirror = Mirror(reflecting: self)
		for case let (label?, value) in mirror.children {
			if count >= offset && !label.hasPrefix("internal_") {
				c.append((label, value))
			}
			count += 1
		}
		return c
	}

	public func firstAsKey() -> (String, Any) {
		let mirror = Mirror(reflecting: self)
		for case let (label?, value) in mirror.children {
			return (label, value)
		}
		return ("id", "unknown")
	}

	public func keyIsEmpty() -> Bool {
		let (_, val) = firstAsKey()
		if val is Int {
			if val as! Int == 0 {
				return true
			} else {
				return false
			}
		} else {
			if (val as! String).isEmpty {
				return true
			} else {
				return false
			}
		}
	}

	open func create() throws {
		// is overridden in an extension
		throw StORMError.notImplemented
	}

}

