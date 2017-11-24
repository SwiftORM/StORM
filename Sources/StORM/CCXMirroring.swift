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
    func allChildren(includingNilValues : Bool) -> [String:Any]
}

open class CCXMirror: CCXMirroring {
    // The superclass count will include CCXMirror, StORM, & PostgresStORM by the time we get to the subclasses we need to process.
    private var superclassCount = 0
    public func didInitializeSuperclass() {
        self.superclassCount += 1
    }
    /// This function goes through all the superclass mirrors.  This is dependent on the CCXMirroring protocol.
    private func superclassMirrors() -> [Mirror] {
        var mirrors : [Mirror] = []
        let mir = Mirror(reflecting: self)
        mirrors.append(mir)
        var currentContext : Mirror?
        for _ in 1...self.superclassCount {
            if currentContext.isNil {
                currentContext = mir.superclassMirror
            } else {
                currentContext = currentContext?.superclassMirror
            }
            if currentContext.isNotNil {
                // we only want to bring in the variables from the superclasses that are beyond PostgresStORM:
                switch String(describing: currentContext!.subjectType) {
                case "CCXMirror", "StORM", "PostgresStORM":
                    break
                default:
                    mirrors.append(currentContext!)
                }
            }
        }
        return mirrors
    }
    /// This returns all the children, even all the superclass mirrored children.  Use allChildren().asData() to return an array of key/values.
    public func allChildren(includingNilValues : Bool = false) -> [String:Any] {
        // Remove out the superclass count which is private:
        let children = self.superclassMirrors().allChildren(includingNilValues: includingNilValues)
        return children
    }
}
