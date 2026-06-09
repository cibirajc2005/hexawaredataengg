use food_delivery_assessment_db
db.createCollection("restaurants")
db.restaurants.insertMany([
 {
 restaurant_id: 1,
 name: "Spice Hub",
 city: "Hyderabad",
 cuisine: "Indian",
 rating: 4.5,
 avg_order_value: 450,
 delivery_available: true,
 tags: ["biryani", "north indian", "family"],
 contact: {
 phone: "9876543210",
 email: "spicehub@mail.com"
 }
 },
 {
 restaurant_id: 2,
 name: "Pizza Corner",
 city: "Bangalore",
 cuisine: "Italian",
 rating: 4.2,
 avg_order_value: 600,
 delivery_available: true,
 tags: ["pizza", "fast food", "cheese"],
 contact: {
 phone: "9876543211",
 email: "pizza@mail.com"
 }
 },
 {
 restaurant_id: 3,
 name: "Green Bowl",
 city: "Chennai",
 cuisine: "Healthy",
 rating: 4.7,
 avg_order_value: 350,
 delivery_available: false,
 tags: ["salad", "vegan", "healthy"],
 contact: {
 phone: null,
 email: "greenbowl@mail.com"
 }
 },
 {
 restaurant_id: 4,
 name: "Burger Street",
 city: "Hyderabad",
 cuisine: "Fast Food",
 rating: 3.9,
 avg_order_value: 300,
 delivery_available: true,
 tags: ["burger", "fries", "fast food"],
 contact: {
 phone: "9876543213",
 email: null
 }
 },
 {
 restaurant_id: 5,
 name: "Royal Tandoor",
 city: "Delhi",
 cuisine: "Indian",
 rating: 4.8,
 avg_order_value: 800,
 delivery_available: true,
 tags: ["tandoor", "north indian", "premium"],
 contact: {
 phone: "9876543214",
 email: "royal@mail.com"
 }
 },
 {
 restaurant_id: 6,
 name: "Tea Tales",
 city: "Pune",
 cuisine: "Cafe",
 rating: 4.1,
 avg_order_value: 200,
 delivery_available: false,
 tags: ["tea", "snacks", "cafe"],
 contact: {
 phone: "9876543215",
 email: "tea@mail.com"
 }
 },
 {
 restaurant_id: 7,
 name: "Ocean Grill",
 city: "Mumbai",
 cuisine: "Seafood",
 rating: 4.6,
 avg_order_value: 900,
 delivery_available: true,
 tags: ["fish", "grill", "premium"],
 contact: {
 phone: "9876543216",
 email: "ocean@mail.com"
 }
 },
 {
 restaurant_id: 8,
 name: "Dosa Point",
 city: "Chennai",
 cuisine: "South Indian",
 rating: 4.3,
 avg_order_value: 250,
 delivery_available: true,
 tags: ["dosa", "idli", "breakfast"],
 contact: {
 phone: null,
 email: null
 }
 }
])

db.restaurants.find()

db.restaurants.find({},{_id:0,name:1,city:1,cuisine:1})

db.restaurants.find({city:"Hyderabad"})

db.restaurants.find({cuisine:"Indian"})

db.restaurants.find({delivery_available:true})

db.restaurants.find({rating:{$gt:4.5}})

db.restaurants.find({avg_order_value:{$lt:400}})

db.restaurants.find({rating:{$gte:4.0,$lte:4.7}})

db.restaurants.find({avg_order_value:{$gte:600}})

db.restaurants.find({city:"Hyderabad",delivery_available:true})

db.restaurants.find({$or:[{city:"Chennai"},{cuisine:"Indian"}]})

db.restaurants.find({delivery_available:false})

db.restaurants.find({city:{$in:["Hyderabad","Delhi","Mumbai"]}})

db.restaurants.find({cuisine:{$in:["Indian","Italian","Cafe"]}})

db.restaurants.find({city:{$nin:["Hyderabad","Bangalore"]}})

db.restaurants.find({name:/^P/})

db.restaurants.find({name:/Point/})

db.restaurants.find({cuisine:/Food/})

db.restaurants.find({"contact.phone":null})

db.restaurants.find({"contact.email":null})

db.restaurants.find({$or:[{"contact.phone":null},{"contact.email":null}]})

db.restaurants.find({tags:"premium"})

db.restaurants.find({tags:"fast food"})

db.restaurants.find({tags:{$all:["north indian","premium"]}})

db.restaurants.find().sort({rating:-1})

db.restaurants.find().sort({rating:-1}).limit(3)

db.restaurants.find().sort({avg_order_value:1})

db.restaurants.find().sort({avg_order_value:-1}).limit(2)

db.restaurants.updateOne({name:"Burger Street"},{$set:{rating:4.0}})

db.restaurants.updateOne({name:"Tea Tales"},{$set:{delivery_available:true}})

db.restaurants.updateMany({},{$set:{active:true}})

db.restaurants.updateOne({name:"Spice Hub"},{$push:{tags:"popular"}})

db.restaurants.updateMany({},{$unset:{active:""}})

db.restaurants.deleteOne({restaurant_id:6})

db.restaurants.deleteMany({rating:{$lt:4.0}})

db.restaurants.countDocuments()

db.restaurants.countDocuments({delivery_available:true})

db.restaurants.distinct("city")

db.restaurants.distinct("cuisine")

db.restaurants.aggregate([{$group:{_id:"$city",count:{$sum:1}}}])

db.restaurants.aggregate([{$group:{_id:"$cuisine",count:{$sum:1}}}])

db.restaurants.aggregate([{$group:{_id:"$cuisine",avgRating:{$avg:"$rating"}}}])

db.restaurants.aggregate([{$group:{_id:"$city",avgOrderValue:{$avg:"$avg_order_value"}}}])

db.restaurants.aggregate([{$group:{_id:"$cuisine",avgOrderValue:{$avg:"$avg_order_value"}}},{$sort:{avgOrderValue:-1}},{$limit:1}])

db.restaurants.aggregate([{$group:{_id:"$cuisine",count:{$sum:1}}},{$match:{count:{$gt:1}}}])