//
//  StORMProtocol.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-30.
//
//

/// Protocol wich enforces the "to" and "makeRow" methods
public protocol StORMProtocol {
	func to(_ this: StORMRow)
	func makeRow()
}
