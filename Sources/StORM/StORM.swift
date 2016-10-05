//
//  StORM.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-30.
//
//

open class StORM {
	//	open var connection		= StORMConnect()     // covariant?
	//	open var cursor			= StORMCursor()
	open var results		= StORMResultSet()
	open var error			= StORMError()

	public init() {}

	// introspection of structure
	public func cols() -> [String:Any] {
		var c = [String:Any]()

		let mirror = Mirror(reflecting: self)
		for child in mirror.children {
			guard let key = child.label else {
				continue
			}
			c[key] = type(of:child.value)
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

}

