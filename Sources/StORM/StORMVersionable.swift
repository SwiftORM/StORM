//
//  StORMVersionable.swift
//  PerfectArcade
//
//  Created by Brendan Seabrook on 2016-10-18.
//
//

public protocol StORMVersionable {
    static var version:String { get }
    static var migrations:[String:((StORMRow) throws -> StORMRow)] { get }
    static var createTable:String { get }
    static var previousTypes:[StORMVersionable.Type] { get }
    var versioningTableName:String { get }
    func migrate() throws
    func setupAndEnableVersioning() throws
}
