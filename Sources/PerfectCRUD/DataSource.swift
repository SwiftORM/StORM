//
//  DataSource.swift
//  PerfectCRUD
//
//  Created by Jonathan Guthrie on 2016-09-23.
//
//

import Foundation

public enum DataSource {
	case Postgres
	case MySQL
	case FileMaker
	case SQLite
	case MongoDB
	case Redis
	case Unknown

	init() {
		self = .Unknown
	}
}

