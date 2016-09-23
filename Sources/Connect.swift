//
//  Connect.swift
//  PerfectORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import Foundation

public class Connect {
	var datasource					= DataSource()
	var credentials					= DataSourceCredentials()

	var database:		String		= ""
	var table:			String		= ""

	
	init() {}

	init(_	ds: DataSource,
			host: String,
			username: String = "",
			password: String = "",
			port: Int = 0) {
		self.datasource = ds
		self.credentials = DataSourceCredentials(host: host, port: port, user: username, pass: password)
	}

	public func select(){}
	public func create(){}
	public func update(){}
	public func upsert(){}

	public func delete(){}




}

