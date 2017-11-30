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
    func allChildren(includingNilValues : Bool, primaryKey: String?) -> [Mirror.Child]
    func primaryKeyLabel() -> String?
}

open class CCXMirror: CCXMirroring {
    // The superclass count will include CCXMirror, StORM, & PostgresStORM by the time we get to the subclasses we need to process.
    private var superclassCount = 0
    public func didInitializeSuperclass() {
        self.superclassCount += 1
    }
    
    /// This is intended to make it easier to specify your primary key, rather than having the id specifically in this model.
    ///
    /// - Returns: This returns the label for the primary key for this model.
    open func primaryKeyLabel() -> String? {
        return nil
    }
    /// This function goes through all the superclass mirrors.  This is dependent on the CCXMirroring protocol.
    private func superclassMirrors() -> [Mirror] {
        var mirrors : [Mirror] = []
        let mir = Mirror(reflecting: self)
        mirrors.append(mir)
        var currentContext : Mirror?
        for _ in 0...self.superclassCount {
            if currentContext.isNil {
                currentContext = mir.superclassMirror
            } else {
                currentContext = currentContext?.superclassMirror
            }
            if currentContext.isNotNil {
                // we only want to bring in the variables from the superclasses that are beyond PostgresStORM:
                mirrors.append(currentContext!)
            }
        }
        return mirrors
    }
    /// This returns all the children, even all the superclass mirrored children.  Use allChildren().asData() to return an array of key/values.
    public func allChildren(includingNilValues : Bool = false, primaryKey: String? = nil) -> [Mirror.Child] {
        // Remove out the superclass count which is private:
        let children = self.superclassMirrors().allChildren(includingNilValues: includingNilValues, primaryKey: primaryKey)
        return children
    }
}
