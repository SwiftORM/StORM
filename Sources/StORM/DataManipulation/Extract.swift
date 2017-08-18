//
//  Extract.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2017-08-18.
//

extension StORM {

	public class Extract {
		// Process strings
		public static func string(_ data: [String: Any], _ name: String, _ def: String = "") -> String? {
			return data[name] as? String ?? def
		}

		// Process integers
		public static func int(_ data: [String: Any], _ name: String, _ def: Int?) -> Int? {
			return data[name] as? Int ?? def
		}

	}
}
