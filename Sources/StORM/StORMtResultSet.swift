//
//  StORMResultSet.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

/// Result Set container class.
/// Collects the Restltset, and the cursor data.
/// Datasurce specific properties can also be set, such as those required for MySQL ResultSet parsing.
open class StORMResultSet {

	/// A container for the ResultSet Rows.
	public var rows: [StORMRow] = [StORMRow]()

	/// The ResultSet's cursor.
	public var cursorData: StORMCursor = StORMCursor()

	/// An array of strings which are the field/column names.
	/// Used exclusively for MySQL datasources at this time.
	public var fieldNames = [String]()	// explicitly for MySQL, but should be adopted globally

	/// A [String:String] which are is the field property information.
	/// Used exclusively for MySQL datasources at this time.
	open var fieldInfo = [String:String]()	// explicitly for MySQL, but should be adopted globally

	/// The foundSetCount property.
	/// Used exclusively for MySQL datasources at this time.
	public var foundSetCount = 0			// explicityly for MySQL, but should be adopted globally

	/// The inserted ID value.
	/// Used exclusively for MySQL datasources at this time.
	public var insertedID = 0			// explicityly for MySQL, but should be adopted globally

	/// Public initializer.
	public init() {}
}
