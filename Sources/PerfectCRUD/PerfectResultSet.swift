//
//  PerfectResultSet.swift
//  PerfectCRUD
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import Foundation

open class PerfectResultSet {
	public var rows: [PerfectRow] = [PerfectRow]()
	public var cursorData: PerfectCRUDCursor = PerfectCRUDCursor()

	public init() {}
}
