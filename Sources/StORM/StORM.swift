//
//  StORM.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-30.
//
//  April 6, 2017: 1.0.3, add support for storing [String] as comma delimited strings


/// Base StORM superclass from which all Database-Connector StORM classes inherit.
/// Provides base functionality and rules.
open class StORM {

	/// Results container of type StORMResultSet.
	open var results		= StORMResultSet()

	/// connection error status of type StORMError.
	open var error			= StORMError()

	/// Contain last error message as string.
	open var errorMsg		= ""

	/// Base empty init function.
	public init() {}

	/// Provides structure introspection to client methods.
	public func cols(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		var count = 0
		let mirror = Mirror(reflecting: self)
		for child in mirror.children {
			guard let key = child.label else {
				continue
			}
			if count >= offset && !key.hasPrefix("internal_") && !key.hasPrefix("_") {
				c.append((key, type(of:child.value)))
				//c[key] = type(of:child.value)
			}
			count += 1
		}
		return c
	}
	
	open func modifyValue(_ v: Any, forKey k: String) -> Any { return v }
	
	/// Returns a [(String,Any)] object representation of the current object.
	/// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
	open func asData(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		var count = 0
		let mirror = Mirror(reflecting: self)
		for case let (label?, value) in mirror.children {
			if count >= offset && !label.hasPrefix("internal_") && !label.hasPrefix("_") {
				if value is [String:Any] {
					c.append((label, modifyValue(try! (value as! [String:Any]).jsonEncodedString(), forKey: label)))
				} else if value is [String] {
					c.append((label, modifyValue((value as! [String]).joined(separator: ","), forKey: label)))
				} else {
					c.append((label, modifyValue(value, forKey: label)))
				}
			}
			count += 1
		}
		return c
	}

	/// Returns a [String:Any] object representation of the current object.
	/// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
	open func asDataDict(_ offset: Int = 0) -> [String: Any] {
		var c = [String: Any]()
		var count = 0
		let mirror = Mirror(reflecting: self)
		for case let (label?, value) in mirror.children {
			if count >= offset && !label.hasPrefix("internal_") && !label.hasPrefix("_") {
				if value is [String:Any] {
					c[label] = modifyValue(try! (value as! [String:Any]).jsonEncodedString(), forKey: label)
				} else if value is [String] {
					c[label] = modifyValue((value as! [String]).joined(separator: ","), forKey: label)
				} else {
					c[label] = modifyValue(value, forKey: label)
				}
			}
			count += 1
		}
		return c
	}

	/// Returns a tuple of name & value of the object's key
	/// The key is determined to be it's first property, which is assumed to be the object key.
	public func firstAsKey() -> (String, Any) {
		let mirror = Mirror(reflecting: self)
		for case let (label?, value) in mirror.children {
			return (label, modifyValue(value, forKey: label))
		}
		return ("id", "unknown")
	}

	/// Returns a boolean that is true if the first property in the class contains a value.
	public func keyIsEmpty() -> Bool {
		let (_, val) = firstAsKey()
        
        // Grab the type of value:
        let type = type(of: val)
        // Check if we are nil, we would then of course have an empty primary key.
        guard String(describing: val) != "nil" else {
            return true
        }
        
        // For now we will be expecting String & Integer key types:
        switch type {
        case is Int.Type, is Int?.Type:
            return (val as! Int == 0)
        case is String.Type, is String?.Type:
            return (val as! String).isEmpty
        default:
            print("[StORM] WARNING: [\(#function)] Unexpected \(type) for PRIMARY KEY.")
            return false
        }
        
	}

	/// The create method is designed to be overridden
	/// If not set in the chile class it will return an error of the enum value .notImplemented
	open func create() throws {
		throw StORMError.notImplemented
	}
	
}

