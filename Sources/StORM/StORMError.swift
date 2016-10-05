//
//  StORMErrors.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-26.
//
//

public enum StORMError: Error {
	case database			// "No Database Specified"
	case error(String)		// "Error"
	case noError			// "No Error"

	init(){
		self = .noError
	}
}
