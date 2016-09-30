//
//  Rows.swift
//  PerfectCRUD
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

open class PerfectRow {

	// id can be uuid, int or string...
	var idInt				= 0
	var idUUID: UUID		= UUID()
	var idString			= ""
	fileprivate var idType: idTypeList		= .Int

	public var data				= Dictionary<String, Any>()

	public init() {}

	public func id(_ val: Int) {
		idType		= .Int
		idInt		= val
	}
	public func id(_ val: UUID) {
		idType		= .UUID
		idUUID		= val
	}
	public func id(_ val: String) {
		idType		= .String
		idString	= val
	}

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

//	public func parse(_ rows: [[String: Any]]) {
//		// parse rows
//	}
}
