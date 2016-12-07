//
//  StORMCursor.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//


/// A struct containing the current cursor information
/// This effectively enables result set pagination
public struct StORMCursor {

	/// Defines how many rows/records/documents to return in the request.
	public var limit:			Int = 50

	/// Defines the starting point for the cursor.
	public var offset:			Int = 0

	/// The number of rows that could have been returned if allowed.
	public var totalRecords:	Int = 0

	/// Empty initializer.
	public init() {}

	/// Initializer for simply the limit and offset properties.
	public init(limit: Int,  offset: Int) {
		self.limit	= limit
		self.offset = offset
	}

	/// Initializer for all three properties.
	public init(limit: Int,  offset: Int, totalRecords: Int) {
		self.limit			= limit
		self.offset			= offset
		self.totalRecords	= totalRecords
	}

}

