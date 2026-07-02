use RetailSalesDB

db.createCollection("campaign_feedback")

db.campaign_feedback.insertOne({
    feedback_id: 1,
    customer_name: "Rahul Sharma",
    store_id: 101,
    product_id: 201,
    campaign_name: "Summer Sale 2026",
    rating: 5,
    feedback: "Excellent discounts and service",
    region: "South",
    feedback_date: new Date("2026-06-13")
})

db.campaign_feedback.insertMany([
{
    feedback_id: 3,
    customer_name: "Kumar",
    store_id: 103,
    product_id: 203,
    campaign_name: "Weekend Sale",
    rating: 5,
    feedback: "Very satisfied",
    region: "East"
},
{
    feedback_id: 4,
    customer_name: "Anitha",
    store_id: 104,
    product_id: 204,
    campaign_name: "Clearance Sale",
    rating: 3,
    feedback: "Average experience",
    region: "West"
}
])

db.campaign_feedback.insertOne({
    feedback_id: 4,
    customer_name: "Arun",
    campaign: {
        name: "Festival Sale",
        budget: 50000
    }
})

db.campaign_feedback.insertOne({
    feedback_id: 5,
    customer_name: "Deepa",
    tags: ["discount","electronics","summer"]
})

var doc = {
    feedback_id: 6,
    customer_name: "Siva",
    rating: 4
}
db.campaign_feedback.insertOne(doc)

db.campaign_feedback.bulkWrite([
{
insertOne:{
document:{
feedback_id:7,
customer_name:"Ram"
}
}
},
{
insertOne:{
document:{
feedback_id:8,
customer_name:"Vijay"
}
}
}
])

db.campaign_feedback.find()

db.campaign_feedback.find(
{},
{
customer_name:1,
rating:1,
_id:0
}
)

db.campaign_feedback.find({
rating:{$gte:4},
region:"South"
})

db.campaign_feedback.find().sort({rating:-1})

db.campaign_feedback.find().sort({rating:-1}).limit(5)

db.campaign_feedback.aggregate([
{
$group:{
_id:"$campaign_name",
avgRating:{
$avg:"$rating"
}
}
}
])

db.campaign_feedback.updateOne(
{feedback_id:1},
{$set:{rating:4}}
)

db.campaign_feedback.updateMany(
{region:"South"},
{$set:{campaign_name:"Mega Sale"}}
)

db.campaign_feedback.updateOne(
{feedback_id:2},
{$inc:{rating:1}}
)

db.campaign_feedback.updateMany(
{},
{$rename:{"feedback":"customer_feedback"}}
)

db.campaign_feedback.updateOne(
{feedback_id:5},
{$push:{tags:"offers"}}
)

db.campaign_feedback.updateOne(
{feedback_id:20},
{
$set:{
customer_name:"New User",
rating:5
}
},
{
upsert:true
}
)

db.campaign_feedback.deleteOne(
{feedback_id:8}
)

db.campaign_feedback.deleteMany(
{rating:{$lt:2}}
)

db.campaign_feedback.deleteMany(
{region:"West"}
)

db.campaign_feedback.deleteMany({
rating:1,
region:"North"
})

db.campaign_feedback.deleteMany({})

db.campaign_feedback.drop()

db.campaign_feedback.createIndex(
{
product_id:1
}
)

db.campaign_feedback.createIndex(
{
region:1
}
)

db.campaign_feedback.createIndex(
{
product_id:1,
region:1
}
)

db.campaign_feedback.createIndex(
{
feedback_id:1
},
{
unique:true
}
)

db.campaign_feedback.createIndex(
{
feedback:"text"
}
)

db.campaign_feedback.getIndexes()
