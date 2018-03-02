//
//  DataSourceCredentials.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

public enum StORMConnectionMethod: String {
	case socket, network
}

/// Storage for current datasource connection properties.
public struct StORMDataSourceCredentials {

	/// Host, which is either a URL or an IP address.
	public var host:			String		= "localhost"

	/// Port at which the client will access the server.
	public var port:			Int			= 0

	/// Username for authentication.
	public var username:		String		= ""

	/// Password for accessing the datasource.
	public var password:		String		= ""

	/// Set the connection method - network (tcp/ip), or socket/dsn.
	public var method:			StORMConnectionMethod		= .network

	public init() {}

	/// Initializer to set properties at instantiation.
	public init(host: String, port: Int = 0, user: String = "", pass: String = "", method: StORMConnectionMethod = .network) {
		self.host = host
		self.port = port
		self.username = user
		self.password = pass
		self.method = method
	}
}
