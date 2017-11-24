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
        var children = self.allChildren()
        // If the StORM primary key is nil, we should assume the first will be the primary key.
        if StORM.primaryKeyLabel.isNil && offset == 1 {
            children.remove(at: children.startIndex)
        } else if offset == 1 && StORM.primaryKeyLabel.isNotNil {
            children.removeValue(forKey: StORM.primaryKeyLabel!)
        }
        for child in children {
            
            if !child.key.hasPrefix("internal_") && !child.key.hasPrefix("_") {
                c.append((child.key, type(of:child.value)))
                
            }
            
        }
        
        return c
    }
    
    open func modifyValue(_ v: Any, forKey k: String) -> Any { return v }
    
    /// Returns a [(String,Any)] object representation of the current object.
    /// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
    open func asData(_ offset : Int = 0) -> [(String, Any)] {
        var c = [(String, Any)]()
        var children = self.allChildren()
        // If the StORM primary key is nil, we should assume the first will be the primary key.
        if StORM.primaryKeyLabel.isNil && offset == 1 {
            children.remove(at: children.startIndex)
        } else if offset == 1 && StORM.primaryKeyLabel.isNotNil {
            children.removeValue(forKey: StORM.primaryKeyLabel!)
        }
        for child in children {
            if !child.key.hasPrefix("internal_") && !child.key.hasPrefix("_") {
                if child.value is [String:Any] {
                    c.append((child.key, modifyValue(try! (child.value as! [String:Any]).jsonEncodedString(), forKey: child.key)))
                } else if child.value is [String] {
                    c.append((child.key, modifyValue((child.value as! [String]).joined(separator: ","), forKey: child.key)))
                } else {
                    c.append((child.key, modifyValue(child.value, forKey: child.key)))
                }
            }
        }
        return c
    }
    
    /// Returns a [String:Any] object representation of the current object.
    /// If any object property begins with an underscore, or with "internal_" it is omitted from the response.
    open func asDataDict(_ offset : Int = 0) -> [String: Any] {
        var c = [String: Any]()
        var children = self.allChildren()
        // If the StORM primary key is nil, we should assume the first will be the primary key.
        if StORM.primaryKeyLabel.isNil && offset == 1 {
            children.remove(at: children.startIndex)
        } else if offset == 1 && StORM.primaryKeyLabel.isNotNil {
            children.removeValue(forKey: StORM.primaryKeyLabel!)
        }
        for child in children {
            if !child.key.hasPrefix("internal_") && !child.key.hasPrefix("_") {
                if child.value is [String:Any] {
                    c[child.key] = modifyValue(try! (child.value as! [String:Any]).jsonEncodedString(), forKey: child.key)
                } else if child.value is [String] {
                    c[child.key] = modifyValue((child.value as! [String]).joined(separator: ","), forKey: child.key)
                } else {
                    c[child.key] = modifyValue(child.value, forKey: child.key)
                }
            }
        }
        return c
    }
    
    /// Returns a tuple of name & value of the object's key
    /// The key is determined to be it's first property, which is assumed to be the object key.
    public func firstAsKey() -> (String, Any) {
        let primaryKey = StORM.primaryKeyLabel
        if primaryKey.isNotNil {
            for case let (label, value) in self.allChildren() {
                if label == primaryKey {
                    return (label, modifyValue(value, forKey: label))
                }
            }
        } else {
            for case let (label, value) in self.allChildren() {
                return (label, modifyValue(value, forKey: label))
            }
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
