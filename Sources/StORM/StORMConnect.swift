//
//  Connect.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

/// The base StORMConnect class.
/// Defines a generic structure containing the client daabase's connection properties.
open class StORMConnect {

	/// Contains the datasource enum value.
	open var datasource							= StORMDataSource()

	/// Container for StORMDataSourceCredentials object.
	open var credentials						= StORMDataSourceCredentials()

	/// The current database.
	open var database:		String				= ""

	/// Last executed statement.
	public var statement:	String				= ""

	/// Last executed statement.
	open var resultCode:	StORMError	= .noError

	public init() {}

	/// Sets the datasource and credentials via init.
	public init(_ ds: StORMDataSource,
	            host: String,
	            username: String = "",
	            password: String = "",
	            port: Int = 0,
				method: StORMConnectionMethod = .network) {
		self.datasource = ds
		self.credentials = StORMDataSourceCredentials(host: host, port: port, user: username, pass: password, method: method)
	}
}

