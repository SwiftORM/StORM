//
//  DataSource.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//


/// Defines possible datasource values
public enum StORMDataSource {
	case Postgres
	case MySQL
	case FileMaker
	case SQLite
	case MongoDB
	case Redis
	case CouchDB
	case Unknown

	init() {
		self = .Unknown
	}
}

