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

	public var fieldNames = [String]()	// explicitly for MySQL, but should be adopted globally
	open var fieldInfo = [String:String]()	// explicitly for MySQL, but should be adopted globally
	public var foundSetCount = 0			// explicityly for MySQL, but should be adopted globally
	public var insertedID = 0			// explicityly for MySQL, but should be adopted globally

	public init() {}
}
