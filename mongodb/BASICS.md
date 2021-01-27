# MongoDB - Basics
A document database designed for ease of development and scaling.  
https://docs.mongodb.com<br><br>

## MongoDB Atlas
It is a [cloud service](https://www.mongodb.com/cloud/atlas) that gives you access to a `500MB` free MongoDB cluster, which is a great alternative to use it as a playground or create POC's.  

### Connections
- Connection through terminal.  
`mongo "mongodb+srv://cluster0.ejbpx.mongodb.net/<dbname>" --username atlas`
- Connection using [MongoDB Compass](https://www.mongodb.com/products/compass) as a UI alternative.  
- Connection using libraries. Depending on language. For Ruby: https://docs.mongodb.com/ruby-driver/master

For this document, we're going to use the default data loaded on MongoDB Atlas, specifically the `sample_training` database.<br><br>

## Databases
Database concept is the same as the traditional SQL databases. List of commands: https://docs.
- List databases.
```
show databases
```
- Use a database.
```
use dbName
db
```
- List of commands available.  
mongodb.com/manual/reference/method/js-database/<br><br>

## Collections
The counterpart of the traditional tables.

- List collections.
```
show collections
```

- Create a collection. We can create a collection by calling a insert or create index, even for unexistent collections.
```
db.collectionName.insertOne({ a: 1 })
db.collectionName.index({ a: 1 })
db.createCollection("collectionName")
```

- Rename a collection.
```
db.collectionName.renameCollection("newCollectionName")
```

- Delete a collection.
```
db.collectionName.drop()

```


- List of commands.  
https://docs.mongodb.com/manual/reference/method/js-collection/<br><br>

## Documents
Registers are now documents, instead of a collection of fixed rows and columns we now have a data structure composed of field (key) and value pairs aka JSON objects!
- The field values can contain not only primitive values but also other documents, arrays and array of documents (Valid [BSON data types](https://docs.mongodb.com/manual/reference/bson-types/))
- Documents can contain different fields / values, we now have schema flexibility! (With a great power comes a great responsability)
- We can embed documents, which means: we don't need a join to retrieve relationships for a document and we reduce I/O activity on the database.
- Support schema validation, deactive per default.
- `_id` is the primary key, can be of any type (Except array), is unique and immutable on the collection. The normal value stored there is an [ObjectId](https://docs.mongodb.com/manual/reference/bson-types/#objectid).

Document example:
```
{
  "_id": ObjectId("5c8eccc1caa187d17ca6ed18"),
  "city": "ACMAR",
  "zip": "35004",
  "loc": {
    "y": 33.584132,
    "x": 86.51557
  },
  "pop": 6055,
  "state": "AL"
}
```
<br>

### `Create`RUD operations.
Remarkable points:
- A insert on a non-existent collection will create it.
- All the insert actions target one collection.
- The write operation is atomic on the level of a single document (Even if the query update a lot of embedded documents for the main document).
- An ObjectId `_id` field is created automatically if you don't assign one yourself.

**Insert one document**
```
db.collectionName.insertOne({ propertyA: "value", propertyB: "anotherValue" })
```

**Insert many documents**
```
db.collectionName.insertMany([
  { propertyA: "value", propertyB: ["a", "b"] },
  { propertyA: "anotherValue", propertyB: ["c"], propertyC: 100 }
])
```
<br>

### C`Read`UD operations.
Remarkable points:
- `query` and `projection` are optional, if not defined will return everything.
- Normal `find` returns a cursor, `findOne` returns a document.
- A [cursor](https://docs.mongodb.com/manual/tutorial/iterate-a-cursor/) is a pointer that you can iterate on the clients to retrieve batches of documents (Default to 20), this would be closed after 10 mins of inactivity (can be disabled).
- Have a [diversity of query operators](https://docs.mongodb.com/manual/reference/operator/query/#query-selectors).
<br><br>

**Find multiple documents**
```
db.collectionName.find(query, projection)
```
<br>

**Find conditions**
```
db.collectionName.find({ fieldName: "someValue", anotherFieldName: 100 })
db.collectionName.find({ fieldName: { $ne: 100 } })
db.collectionName.find({ fieldName: { $lte: 100, $exists: true } })
```
<br>

**Find conditions - query arrays**
```
Array contains a desired value.
db.collectionName.find({ tagsField: "ruby" })

Array contains all the desired values.
db.collectionName.find({ arrayField: { $all: ["ruby", "rails"] } })

Array contains at least one of the desired values.
db.collectionName.find({ arrayField: { $in: ["ruby", "rails"] } })

Array don't contain the desired values.
db.collectionName.find({ arrayField: { $nin: ["java"] } })

Array match the criterias in at least one element.
db.collectionName.find({ anotherArrayField: { $elemMatch: { $gt: 7, $lte: 9 } } })

Search on a array of objects.
db.collectionName.find({ arrObjects: { propertyOne: "A", propertyTwo: 2 }})

Search on a array of objects using operators.
db.collectionName.find({ 'arrObjects.propertyTwo': { $lte: 5 } }})
```
<br>

**Find conditions - projection**  
`_id` is always returned per default.
```
db.collectionName.find({ fieldName: "someValue" }, { fieldName: 1 })

Will return:
[
  {
    "_id": ObjectId(""),
    "fieldName": "someValue"
  },
  {
    "_id": ObjectId(""),
    "fieldName": "someValue"
  },
]

```
<br>

**Find distinct**   
`db.collectionName.distinct(field, query, options)` 
```
db.collectionName.distinct("status", { fieldName: "someValue" })

Will return:
["draft", "process", ...]

```
<br>

**Find one document**. Internally uses a `find()` method with a `limit` of one.
```
db.collectionName.findOne(query, projection)
```
<br>

### CR`Update`D operations.
Remarkable points:
- Each update is atomic to the document, even if the whole process is not atomic (In the case of update many documents).
- Index are important to have consistent data.
- Once set the `_id` field cannot change it's value.
- [Operators list](https://docs.mongodb.com/manual/reference/operator/update/).
- `updateOne` and `updateMany` update only the requested fields, while `replaceOne` replace all the document.
<br><br>

*Commands*
```
db.collection.updateOne(query, updateQuery, options)
db.collection.updateMany(query, updateQuery, options)
db.collection.replaceOne(query, updateQuery, options)
```

*Examples*
```
Basic form:
db.collectionName.updateOne(
  { status: "unsent" },
  {
    $set: { views: 0, "users.kind": "guests" }
  }
)

Basic form to remove a field:
db.collectionName.updateMany(
  { _id_: ObjectId("1234567890asdf1234") },
  {
    $unset: { fieldToRemove: true }
  }
)

Basic form to add an element to an array:
db.collectionName.updateOne(
  { _id_: ObjectId("1234567890asdf1234") },
  {
    $addToSet: { tags: "programming" }
  }
)

Add multiple elements to an array:
db.collectionName.updateOne(
  { _id_: ObjectId("1234567890asdf1234") },
  {
    $addToSet: { tags: { $each: ["ruby", "on", "rails"] } }
  }
)
```
<br>

### CRU`Delete` operations.
Remarkable points:
- Both commands return the ackknowledge and delete counts of the operation.
- Can raise exception depending on the collection type.
- Can be used in transactions.
<br><br>

*Commands*
```
db.collection.deleteOne(query, options)
db.collection.deleteMany(query, options)
```

*Examples*
```
Basic form for one document:
db.collectionName.deleteOne(
  { _id: 1 }
)

Basic form for many documents:
db.collectionName.deleteMany(
  { status: "failed" }
)
```