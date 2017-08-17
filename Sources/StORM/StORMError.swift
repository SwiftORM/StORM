//
//  StORMErrors.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-26.
//
//

/// Foundation error enum container.
public enum StORMError: Error {
	/// "No Database Specified"
	case database

	/// Error with detail message.
	case error(String)

	/// No error generated
	case noError

	/// Connection Error
	case connectionError

	/// Not Implemented
	case notImplemented

	/// No record found error (if rrequired)
	case noRecordFound

	/// Default value when created is .noError
	init(){
		self = .noError
	}

	/// String representation of the error enum value.
	public func string() -> String {
		switch self {
		case .database:
			return "No Database Specified"

		case .noRecordFound:
			return "No Record Found"

		case .noError:
			return "No Error"
			
		case .connectionError:
			return "Connection Error"

		case .notImplemented:
			return "Not Implemented"

		default:
			return "Error"
		}
	}
}
