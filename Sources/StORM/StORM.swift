//
//  StORM.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-30.
//
//  April 6, 2017: 1.0.3, add support for storing [String] as comma delimited strings


/// Variable defining the global debug state for all classes inheriting from the StORM superclass.
/// When true, certain methods will generate a debug message under certain conditions.
public var StORMdebug = false

/// If you set the StORMIgnoreClassString field, you support the parent class property lookup until you find the set field class, or you only support sub class property lookups
public var StORMIgnoreClassString:String = ""
/// Set the suffix to the primary key and defaults to id
public var StORMPrimarykeySuffix:String = "id"

/// Base StORM superclass from which all Database-Connector StORM classes inherit.
/// Provides base functionality and rules.
open class StORM {

	/// Results container of type StORMResultSet.
	open var results		= StORMResultSet()

	/// connection error status of type StORMError.
	open var error			= StORMError()

	/// Contain last error message as string.
	open var errorMsg		= ""
    
    /// Database primary key
    private var primary:(String,Any)?

	/// Base empty init function.
	public init() {}

	/// Provides structure introspection to client methods.
	public func cols(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		let mirror = Mirror(reflecting: self)
		let mirrorData = StORMMirrorData.mirror(mirror: mirror)
        for child in mirrorData.childs {
            c.append((child.label, type(of: child.value)))
        }
		return c
	}
    
    
	
	open func modifyValue(_ v: Any, forKey k: String) -> Any { return v }
	
	/// Returns a [(String,Any)] object representation of the current object.
	/// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
	public func asData(_ offset: Int = 0) -> [(String, Any)] {
		var c = [(String, Any)]()
		let mirror = Mirror(reflecting: self)
        let mirrorData = StORMMirrorData.mirror(mirror: mirror)
        for child in mirrorData.childs {
            if child.value is [String:Any] {
                c.append((child.label, modifyValue(try! (child.value as! [String:Any]).jsonEncodedString(), forKey: child.label)))
            } else if child.value is [String] {
                c.append((child.label, modifyValue((child.value as! [String]).joined(separator: ","), forKey: child.label)))
            } else {
                c.append((child.label, modifyValue(child.value, forKey: child.label)))
            }
        }
		return c
	}

	/// Returns a [String:Any] object representation of the current object.
	/// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
	public func asDataDict(_ offset: Int = 0) -> [String: Any] {
		var c = [String: Any]()
        for (label,value) in asData(offset) {
            c[label] = value
        }
		return c
	}

	/// Returns a tuple of name & value of the object's key
	/// The key is determined to be it's first property, which is assumed to be the object key.
	public func firstAsKey() -> (String, Any) {
		let mirror = Mirror(reflecting: self)
        guard let child = StORMMirrorData.mirror(mirror: mirror).primary else {
            return ("id", "unknown")
        }
		return (child.label, modifyValue(child.value, forKey: child.label))
	}

	/// Returns a boolean that is true if the first property in the class contains a value.
	public func keyIsEmpty() -> Bool {
		let (_, val) = firstAsKey()
		if val is Int {
			if val as! Int == 0 {
				return true
			} else {
				return false
			}
        } else if val is Int32 {
            if val as! Int32 == 0 {
                return true
            } else {
                return false
            }
        } else if val is String {
            if (val as! String).isEmpty {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
	}

	/// The create method is designed to be overridden
	/// If not set in the chile class it will return an error of the enum value .notImplemented
	open func create() throws {
		throw StORMError.notImplemented
	}
    
}

