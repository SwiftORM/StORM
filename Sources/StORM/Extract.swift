//
//  Extract.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2018-03-02.
//

import Foundation
import SwiftMoment

extension StORM {

	public class Extract {

		// =======================================================================================
		// Process strings
		// =======================================================================================
		public static func string(_ data: [String: Any], _ name: String, _ def: String? = String()) -> String? {
			return data[name] as? String ?? def
		}

		// =======================================================================================
		// Process integers
		// The Int32 is here for some MySQL use cases
		// =======================================================================================
		public static func int(_ data: [String: Any], _ name: String, _ def: Int? = Int()) -> Int? {
			if let x = data[name] as? Int32, x > 0 {
				return Int(x)
			}
			return data[name] as? Int ?? def
		}

		// =======================================================================================
		// Process date
		// Note this leverages SwiftMoment
		// =======================================================================================
		public static func date(_ data: [String: Any], _ name: String, _ def: Date? = Date()) -> Date? {
			return moment(Extract.string(data, name)!)?.date ?? def
		}

		// =======================================================================================
		// Double
		// =======================================================================================
		public static func double(_ data: [String: Any], _ name: String, _ def: Double? = Double()) -> Double? {
			if let d = data[name] as? Double {
				return d
			} else if let d = data[name] as? Float {
				return Double(d)

			}
			return Double((data[name] as? String) ?? "\(def ?? 0.00)")
//			return Double((data[name] as? Float) ?? Float(def ?? 0.00))
		}

		// =======================================================================================
		// Bool
		// =======================================================================================
		public static func bool(_ data: [String: Any], _ name: String, _ def: Bool? = Bool()) -> Bool? {
			return data[name] as? Bool ?? def
		}

		// =======================================================================================
		// Bytes / UInt8 array
		// =======================================================================================
		public static func bytes(_ data: [String: Any], _ name: String, _ def: [UInt8]? = [UInt8]()) -> [UInt8]? {
			return data[name] as? [UInt8] ?? def
		}
		
		// =======================================================================================
		// Array Of Strings
		// =======================================================================================
		public static func arrayOfStrings(_ data: [String: Any], _ name: String, _ def: [String]? = [String]()) -> [String]? {
			return (data[name] as? String ?? "").split(separator: ",").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) } // note default ignored right now
		}

		// =======================================================================================
		// Array Of Integers
		// =======================================================================================
		public static func arrayOfIntegers(_ data: [String: Any], _ name: String, _ def: [Int]? = [Int]()) -> [Int]? {
			return (data[name] as? String ?? "").split(separator: ",").map{ Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0 } // note default ignored right now
		}

		// =======================================================================================
		// Array Of Any
		// =======================================================================================
		public static func arrayOfAny(_ data: [String: Any], _ name: String, _ def: [Any]? = [Any]()) -> [Any]? {
			return data[name] as? [Any] ?? def // not sure about this right now...
		}

		// =======================================================================================
		// Return a JSON-type map [String:Any]
		// =======================================================================================
		public static func map(_ data: [String: Any], _ name: String, _ def: [String:Any]? = [String:Any]()) -> [String:Any]? {
			return data[name] as? [String:Any] ?? def
		}


	}
}





