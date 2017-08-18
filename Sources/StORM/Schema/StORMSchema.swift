//
//  StORMSchema.swift
//  StORM
//
//  Created by Jonathan Guthrie on 2017-08-18.
//

/// Base Data Types for StORM
public enum StORMType {
	/// Base types: Extend as needed
	case int, string(Int), double, bool, bytes, date, json, bjson
	/// Special data types that can have particular processing applied
	case array, map
}


/// Used for defining data structure in a more finely granular fashion
public struct StORMSchemaField {
	public var name: String			= ""
	public var type: StORMType		= .string(256)
	public var isOptional: Bool		= false
	public var isUnique: Bool		= false
	public var isPrimaryKey: Bool	= false
	public var isEncrypted: Bool	= false
	public var defaultValue: Any?

	public init(
		name: String,
		type: StORMType,
		isOptional: Bool = false,
		isUnique: Bool = false,
		isPrimaryKey: Bool = false,
		isEncrypted: Bool = false,
		defaultValue: Any = ""
		) {
		self.name = name
		self.type = type
		self.isOptional = isOptional
		self.isUnique = isUnique
		self.isPrimaryKey = isPrimaryKey
		self.isEncrypted = isEncrypted
		self.defaultValue = defaultValue
	}
}

public struct StORMSchema {

	/// Table name
	public var name: String 				= ""

	/// Columns (aka fields)
	public var fields: [StORMSchemaField] 	= [StORMSchemaField]()

	/// Options that can be specified at table-create time
	public var options: String 				= ""
}
