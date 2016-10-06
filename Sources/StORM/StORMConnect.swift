//
//  Connect.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//


open class StORMConnect {

	open var datasource							= StORMDataSource()
	open var credentials						= StORMDataSourceCredentials()

	open var database:		String				= ""

	/// Last executed statement
	public var statement:	String				= ""

	/// Last executed statement
	open var resultCode:	StORMError	= .noError

	public init() {}

	public init(_	ds: StORMDataSource,
	            host: String,
	            username: String = "",
	            password: String = "",
	            port: Int = 0) {
		self.datasource = ds
		self.credentials = StORMDataSourceCredentials(host: host, port: port, user: username, pass: password)
	}
}

