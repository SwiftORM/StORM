//
//  StORMDebug.swift
//  StORM
//
//  Created by Josef Zoller on 09.10.18.
//

/// StORMDebug sets, whether or not some methods of StORM classes generate debug messages
/// and where the log file is located
public struct StORMDebug {
    private init(){}
    
    /// The global debug state for all classes inheriting from the StORM superclass.
    /// When true, certain methods will generate a debug message under certain conditions.
    public static var active = false
}
