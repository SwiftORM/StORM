//
//  Joins.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2016-09-24.
//
//

import Foundation

public struct DataSourceJoin {
	public var table:			String		= ""
	public var direction:		JoinType
	public var onCondition:		String		= ""

	public init() {
		direction = .normal
	}
	public init(table: String,  onCondition: String = "", direction: JoinType = .normal) {
		self.table = table
		self.direction = direction
		self.onCondition = onCondition
	}
}

public enum JoinType {
	case INNER
	case OUTER
	case LEFT
	case RIGHT
	case STRAIGHT
	case normal
}
