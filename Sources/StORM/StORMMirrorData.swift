//
//  StORMMirrorData.swift
//  StORM
//
//  Created by 张行 on 2017/8/14.
//
//

import Foundation

/// A field that supports the search for subclasses and the parent class matches the attribute seat database
public class StORMMirrorData {
    public var childs:[StORMMirrorDataChild] = [] /// In addition to the primary key, the database field
    public var primary:StORMMirrorDataChild? /// The primary key field may exist or does not exist
    
    /// Resolve Mirror to find the criteria for the database field and the primary key
    public static func mirror(mirror:Mirror) -> StORMMirrorData {
        let mirrorData = StORMMirrorData()
        for child in mirrorData.mirrorData(mirror: mirror) {
            mirrorData.childs.append(StORMMirrorDataChild(label: child.0, value: child.1))
        }
        return mirrorData
    }
    
    public func mirrorData(mirror:Mirror) -> [(String,Any)] {
        var c:[(String,Any)] = []
        if "\(mirror.subjectType)" == StORMIgnoreClassString {
            return c
        }
        var count:Int = 0
        for case let (label?,value) in mirror.children {
            if isFilterKey(key: label) {
                continue
            }
            if count == 0 && isPrimaryKey(key: label) && (self.primary == nil){
                self.primary = StORMMirrorDataChild(label: label, value: value)
            } else {
                c.append((label,value))
            }
            count += 1
        }
        if let superMirror = mirror.superclassMirror, StORMIgnoreClassString.characters.count > 0 {
            c.append(contentsOf: mirrorData(mirror: superMirror))
        }
        return c
    }
    
    ///Is the filter field, YES represents the filter field, and NO stands for the database table field
    public func isFilterKey(key:String) -> Bool {
        if key.hasPrefix("internal_") {
            return true
        }
        if key.hasPrefix("_") {
            return true
        }
        return false
    }
    
    /// Is it the primary key for the database? YES stands for the primary key, and NO stands for not a primary key
    public func isPrimaryKey(key:String) -> Bool {
        return key.hasSuffix(StORMPrimarykeySuffix)
    }
}

public struct StORMMirrorDataChild {
    var label:String
    var value:Any
}
