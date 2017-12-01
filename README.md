# StORM: Swift ORM

Core StORM Library



StORM is a modular ORM for Swift, layered on top of Perfect.

It aims to be easy to use, but flexible, and maintain consistency between datasource implementations for the user: you, the developer. It tries to allow you to write great code without worrying about the details of how to interact with the database.

Please see the full documentation at: [https://www.perfect.org/docs/StORM.html](https://www.perfect.org/docs/StORM.html)

# Latest Updates:

- Increased flexibility with determining the primary key, without having to have it your first declared variable in your model.
- Includes subclassing support.
- Includes optional variable support. 

## Usage:
### Example -> Conforming to StORMirroring:
Say we have to models using PostgresStORM:

```
class AuditFields: PostgresStORM {
    
    /// This is when the table row has been created.
    var created : Int?           = nil
    /// This is the id of the user that has created the row.
    var createdby : String?  = nil
    /// This is when the table row has been modified.
    var modified : Int?          = nil
    /// This is the id of the user that has modified the row.
    var modifiedby : String? = nil
    
    // This is needed when created a subclass containing other fields to re-use for other models.
    override init() {
        super.init()
        self.didInitializeSuperclass()
    }
}

// The outer most class does not need to override init & call didInitializeSuperclass.  This helps with identifying the id in the model.
class TestUser2: AuditFields {
    // In this example we have id at the top but that is not mandatory now if you implement the primaryKeyLabel overrided function.
    var id : Int?                             = nil
    var firstname : String?          = nil {
        didSet {
            if oldValue != nil && firstname == nil {
                self.nullColumns.insert("firstname")
            } else if firstname != nil {
                self.nullColumns.remove("firstname")
            }
        }
    }
    var lastname : String?          = nil {
        didSet {
            if oldValue != nil && lastname == nil {
                self.nullColumns.insert("lastname")
            } else if firstname != nil {
                self.nullColumns.remove("lastname")
            }
        }
    }
    var phonenumber : String? = nil {
        didSet {
            if oldValue != nil && phonenumber == nil {
                self.nullColumns.insert("phonenumber")
            } else if firstname != nil {
                self.nullColumns.remove("phonenumber")
            }
        }
    }
    
    override open func table() -> String {
        return "testuser2"
    }
    
    override func to(_ this: StORMRow) {
        
        // Audit fields:
        id                = this.data["id"] as? Int
        created     = this.data["created"] as? Int
        createdby     = this.data["createdby"] as? String
        modified     = this.data["modified"] as? Int
        modifiedby     = this.data["modifiedby"] as? String
        
        firstname        = this.data["firstname"] as? String
        lastname        = this.data["lastname"] as? String
        phonenumber            = this.data["phonenumber"] as? String
        
    }
    
    func rows() -> [TestUser2] {
        var rows = [TestUser2]()
        for i in 0..<self.results.rows.count {
            let row = TestUser2()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
    
}
```

Notice that you only need to call the didInitializeSuperclass() function in the superclass of TestUser2.  You should NOT call this in your main model, in this case TestUser2.

### Example -> Getting all the children:
```
// Getting all the children (including nil values or NOT)
// Returns an array of children, making sure the overrided function primaryKeyLabel takes the child for that key and places it in the first index of the array:
self.allChildren(includingNilValues: true, primaryKey: self.primaryKeyLabel()) 
```

This provides the capability for PostgresStORM and other database supported StORM modules to be given the ability to subclass PostgresStORM objects deeper than just the single mirror of the class.

StORMMirroring also gives you the flexibility to place your primary key in a superclass model.  All you would need to do is override the primaryKeyLabel function that StORMMirroring offers.  This ensures that when we create the array of children from all the mirrors, it places the primary key as the first child in the array.

### Supporting Optionals in other database-StORM Modules:
- Make sure to keep track of going from an optional Non-nil value to nil, to update NULL/DEFAULT or NULL.  See TestUser2 model. 

### Other -> Automatic Auditing For other database-StORM Modules:
- StORMMirroring also supports automatic created & modified values to come back if they exist in the model.  They are intended to be used as integers to store as epoch timestamps.  Make sure to skip over modified or created depending on if you are creating a new record or modifying a record.

