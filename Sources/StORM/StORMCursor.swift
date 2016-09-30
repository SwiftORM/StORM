//
//  StORMCursor.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import Foundation

public struct StORMCursor {
	public var limit:			Int = 50
	public var offset:			Int = 0
	public var totalRecords:	Int = 0

	public init() {}

	public init(limit: Int,  offset: Int) {
		self.limit	= limit
		self.offset = offset
	}
	public init(limit: Int,  offset: Int, totalRecords: Int) {
		self.limit			= limit
		self.offset			= offset
		self.totalRecords	= totalRecords
	}

}

