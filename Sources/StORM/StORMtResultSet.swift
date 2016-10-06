//
//  StORMResultSet.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

open class StORMResultSet {
	public var rows: [StORMRow] = [StORMRow]()
	public var cursorData: StORMCursor = StORMCursor()

	public init() {}
}
