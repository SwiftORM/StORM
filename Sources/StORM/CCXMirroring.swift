//
//  CCXMirroring.swift
//
//  Created by Ryan Coyne on 11/22/17.
//  Copyright © 2017 ClearCodeX, Inc. All rights reserved.
//

//
//  CCXMirror.swift
//
//
//  Created by Ryan Coyne on 11/17/17.
//  Copyright © 2017 ClearCodeX, Inc. All rights reserved.
//

public protocol CCXMirroring {
    func didInitializeSuperclass()
    func allChildren() -> [String:Any]
}

open class CCXMirror: CCXMirroring {
    // The superclass count will include CCXMirror, StORM, & Postgres-StORM by the time we get to the subclasses we need to process.
    private var superclassCount = 3
    public func didInitializeSuperclass() {
        self.superclassCount += 1
    }
    /// This function goes through all the superclass mirrors.  This is dependent on the CCXMirroring protocol.
    private func superclassMirrors() -> [Mirror] {
        var mirrors : [Mirror] = []
        let mir = Mirror(reflecting: self)
        // Make sure we aren't adding in the CCXMirror or StORM mirrors:
        switch mir.subjectType {
        case is CCXMirror.Type, is StORM.Type:
            break
        default:
            mirrors.append(mir)
        }
        var currentContext : Mirror?
        for _ in 0...self.superclassCount {
            if currentContext.isNil {
                currentContext = mir.superclassMirror
            } else {
                currentContext = currentContext?.superclassMirror
            }
            // Make sure we aren't adding in the CCXMirror or StORM mirrors:
            switch currentContext?.subjectType {
            case is CCXMirror.Type?, is StORM.Type?:
                break
            default:
                if currentContext.isNotNil {
                    mirrors.append(currentContext!)
                }
            }
        }
        return mirrors
    }
    /// This returns all the children, even all the superclass mirrored children.  Use allChildren().asData() to return an array of key/values.
    public func allChildren() -> [String:Any] {
        // Remove out the superclass count which is private:
        var children = self.superclassMirrors().allChildren
        children.removeValue(forKey: "superclassCount")
        return children
    }
}

