require 'mongo'
client = Mongo::Client.new('mongodb://127.0.0.1:27017/test1')
db = client.database
collection = Mongo::Collection.new(db, 'test_collection')

doc= {
    name:"xd",
    id:"xd"
}

result = collection.insert_one(doc)
result.n