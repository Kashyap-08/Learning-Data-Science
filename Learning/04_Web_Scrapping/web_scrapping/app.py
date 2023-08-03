import pymongo

# url = 'mongodb://Demo:Demo@ac-5a4bgl4-shard-00-00.n7r3noi.mongodb.net:27017,ac-5a4bgl4-shard-00-01.n7r3noi.mongodb.net:27017,ac-5a4bgl4-shard-00-02.n7r3noi.mongodb.net:27017/?ssl=true&replicaSet=atlas-g2coa4-shard-0&authSource=admin&retryWrites=true&w=majority'
# client = pymongo.MongoClient(url)
client = pymongo.MongoClient("mongodb+srv://Demo:Demo@cluster01.n7r3noi.mongodb.net/?retryWrites=true&w=majority")
db = client.test
print(db)

d = [{
    "name":"Kashyap",
    "last_name":"Kolhe",
    "email":"kashyap@gmail.com"
    },
    {
        "item": "canvas",
        "qty": 100,
        "size": {"h": 28, "w": 35.5, "uom": "cm"},
        "status": "A",
    },
    ]

db1 = client['mongotest']
coll = db1['test']
coll.insert_many(d)