//
//  Connect.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import Foundation

protocol StORMProtocol {
	func select() -> String
	func create() -> String
	func update() -> String
	func upsert() -> String
	func delete() -> String

}

open class Connect {

	open var datasource							= DataSource()
	open var credentials						= DataSourceCredentials()

	open var database:		String				= ""

	/// Manually set table
	// Convenience shortcut var
	open var table:			String				= ""

	/// Last executed statement
	public var statement:	String				= ""

	/// Last executed statement
	public var resultCode:	StORMError	= .noError

	public init() {}

	public init(_	ds: DataSource,
	            host: String,
	            username: String = "",
	            password: String = "",
	            port: Int = 0) {
		self.datasource = ds
		self.credentials = DataSourceCredentials(host: host, port: port, user: username, pass: password)
	}


//
//	public func select() -> String {
//		return "selected"
//	}
//	public func create() -> String {
//		return "created"
//	}
//	public func update() -> String {
//		return "updated"
//	}
//	public func upsert() -> String {
//		return "upserted"
//	}
//	public func delete() -> String {
//		return "deleted"
//	}





}

