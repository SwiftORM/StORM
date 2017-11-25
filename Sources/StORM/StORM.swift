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

/// Base StORM superclass from which all Database-Connector StORM classes inherit.
/// Provides base functionality and rules.
open class StORM : CCXMirror {
    
    /// Results container of type StORMResultSet.
    open var results        = StORMResultSet()
    
    /// connection error status of type StORMError.
    open var error            = StORMError()
    
    /// Contain last error message as string.
    open var errorMsg        = ""
    
    /// Base empty init function.
    public override init() {}
    
    /// primary key label (not assuming the first child is the id).
    public static var primaryKeyLabel : String? = nil
    
    /// Provides structure introspection to client methods.
    public func cols(_ offset : Int = 0) -> [(String, Any)] {
        
        var c = [(String, Any)]()
        var count = 0
        // If the StORM primary key is nil, we should assume the first will be the primary key.
        for child in self.allChildren(primaryKey: self.primaryKeyLabel()) {
            guard let key = child.label else {
                continue
            }
            if !key.hasPrefix("internal_") && !key.hasPrefix("_") {
                c.append((child.label!, type(of:child.value)))
            }
            count += 1
        }
        
        return c
    }
    
    open func modifyValue(_ v: Any, forKey k: String) -> Any {
        
        guard String(describing: v) != "nil" else { return v }
        switch type(of: v) {
        case is Int?.Type:
            return v as! Int
        case is String?.Type:
            return v as! String
        case is Double?.Type:
            return v as! Double
        case is Float?.Type:
            return v as! Float
        case is [String]?.Type:
            return v as! [String]
        case is [String:Any]?.Type:
            return try! (v as! [String:Any]).jsonEncodedString()
        default:
            return v
        }
        
    }
    
    /// Returns a [(String,Any)] object representation of the current object.
    /// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
    open func asData(_ offset : Int = 0) -> [(String, Any)] {
        var c = [(String, Any)]()
        var count = 0
        for case let (label?, value) in self.allChildren(primaryKey: self.primaryKeyLabel()) {
            if count >= offset && !label.hasPrefix("internal_") && !label.hasPrefix("_") {
                c.append((label, modifyValue(value, forKey: label)))
            }
            count += 1
        }
        return c
    }
    
    /// Returns a [String:Any] object representation of the current object.
    /// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
    open func asDataDict(_ offset : Int = 0) -> [String: Any] {
        var c = [String: Any]()
        var count = 0
        for case let (label?, value) in self.allChildren(primaryKey: self.primaryKeyLabel()) {
            if count >= offset && !label.hasPrefix("internal_") && !label.hasPrefix("_") {
                c[label] = modifyValue(value, forKey: label)
            }
            count += 1
        }
        return c
    }
    
    /// Returns a tuple of name & value of the object's key
    /// The key is determined to be it's first property, which is assumed to be the object key.
    public func firstAsKey() -> (String, Any) {
        for case let (label, value) in self.allChildren(includingNilValues: true, primaryKey: self.primaryKeyLabel()) {
            return (label!, modifyValue(value, forKey: label!))
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
