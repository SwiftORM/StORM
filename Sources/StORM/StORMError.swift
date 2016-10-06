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
	case notImplemented		// "Not Implemented"
	case noRecordFound		// no record

	init(){
		self = .noError
	}

	public func string() -> String {
		switch self {
		case .database:
			return "No Database Specified"

		case .noRecordFound:
			return "No Record Found"

		case .noError:
			return "No Error"
			
		case .notImplemented:
			return "Not Implemented"

		default:
			return "Error"
		}
	}
}
