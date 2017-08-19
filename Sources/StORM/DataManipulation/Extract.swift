//
//  Extract.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2017-08-18.
//

import Foundation
import SwiftMoment

extension StORM {

	public class Extract {

		// =======================================================================================
		// Process strings
		// =======================================================================================
		public static func string(_ data: [String: Any], _ name: String, _ def: String = "") -> String? {
			return data[name] as? String ?? def
		}

		// =======================================================================================
		// Process integers
		// =======================================================================================
		public static func int(_ data: [String: Any], _ name: String, _ def: Int?) -> Int? {
			return data[name] as? Int ?? def
		}

		// =======================================================================================
		// Process date
		// Note this leverages SwiftMoment
		// =======================================================================================
		public static func date(_ data: [String: Any], _ name: String, _ def: Date?) -> Date? {
			return moment(Extract.string(data, name)!)?.date ?? def
		}

		// =======================================================================================
		// Double
		// =======================================================================================
		public static func double(_ data: [String: Any], _ name: String, _ def: Double?) -> Double? {
			return data[name] as? Double ?? def
		}

		// =======================================================================================
		// Bool
		// =======================================================================================
		public static func bool(_ data: [String: Any], _ name: String, _ def: Bool?) -> Bool? {
			return data[name] as? Bool ?? def
		}

		// =======================================================================================
		// Bytes / UInt8 array
		// =======================================================================================
		public static func bytes(_ data: [String: Any], _ name: String, _ def: [UInt8]?) -> [UInt8]? {
			return data[name] as? [UInt8] ?? def
		}








		// =======================================================================================
		// Array Of Strings
		// =======================================================================================
		public static func arrayOfStrings(_ data: [String: Any], _ name: String, _ def: [String]?) -> [String]? {
			return data[name] as? [String] ?? def
		}

		// =======================================================================================
		// Array Of Integers
		// =======================================================================================
		public static func arrayOfIntegers(_ data: [String: Any], _ name: String, _ def: [Int]?) -> [Int]? {
			return data[name] as? [Int] ?? def
		}

		// =======================================================================================
		// Array Of Any
		// =======================================================================================
		public static func arrayOfAny(_ data: [String: Any], _ name: String, _ def: [Any]?) -> [Any]? {
			return data[name] as? [Any] ?? def
		}

		// =======================================================================================
		// Return a JSON-type map [String:Any]
		// =======================================================================================
		public static func map(_ data: [String: Any], _ name: String, _ def:  [String:Any]?) -> [String:Any]? {
			return data[name] as? [String:Any] ?? def
        }

	}
}
