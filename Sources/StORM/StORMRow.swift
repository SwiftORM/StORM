//
//  StORMRow.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import PerfectLib

fileprivate enum idTypeList {
	case String
	case Int
	case UUID
}

/// The foundation container for a result row.
open class StORMRow {

	/// The idInt is the container for an integer ID value.
	var idInt				= 0

	/// The idUUID is the container for a UUID ID value.
	var idUUID: UUID		= UUID()

	/// The idString is the container for a textual ID value.
	var idString			= ""

	fileprivate var idType: idTypeList		= .Int

	/// The container for the row's data.
	public var data				= Dictionary<String, Any>()

	/// Empty public initializer.
	public init() {}

	/// Used to set the id value of the row if an integer
	public func id(_ val: Int) {
		idType		= .Int
		idInt		= val
	}

	/// Used to set the id value of the row if a UUID
	public func id(_ val: UUID) {
		idType		= .UUID
		idUUID		= val
	}

	/// Used to set the id value of the row if a string
	public func id(_ val: String) {
		idType		= .String
		idString	= val
	}

	/// Retrieves the value of the ID as set.
	public func id() -> Any {
		switch idType {
		case .Int:
			return idInt
		case .UUID:
			return idUUID
		default:
			return idString
		}
	}

}
