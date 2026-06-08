use("food_delivery_capstone_db")

db.customers.find()

db.restaurants.find()

db.customers.find({}, { _id: 0, name: 1, city: 1, membership: 1 })

db.customers.find({ city: "Hyderabad" })

db.customers.find({ membership: "Gold" })

db.restaurants.find({ rating: { $gt: 4.5 } })

db.orders.find({ order_amount: { $gt: 500 } })

db.orders.find({ order_status: "Delivered" })

db.orders.find({ order_status: "Cancelled" })

db.customers.find({ phone: null })

db.orders.find({ order_amount: { $gte: 400, $lte: 700 } })

db.customers.find({
  city: { $in: ["Hyderabad", "Delhi", "Mumbai"] }
})

db.restaurants.find({
  cuisine: { $in: ["Indian", "Fast Food"] }
})

db.orders.find({
  "payment.status": { $ne: "Success" }
})

db.orders.find({
  delivery_time_minutes: null
})

db.orders.find({
  order_rating: { $gte: 4 }
})

db.restaurants.find({
  city: { $nin: ["Bangalore", "Chennai"] }
})

db.orders.find({
  "items.item_name": "Biryani"
})

db.orders.find({
  "items.item_name": "Pizza"
})

db.orders.find({
  items: {
    $elemMatch: {
      quantity: { $gt: 1 }
    }
  }
})

db.orders.find({
  items: {
    $elemMatch: {
      price: { $gt: 300 }
    }
  }
})

db.orders.find({}, {
  _id: 0,
  order_id: 1,
  items: 1
})

db.restaurants.find().sort({ rating: -1 })

db.restaurants.find().sort({ rating: -1 }).limit(3)

db.orders.find().sort({ order_amount: -1 })

db.orders.find().sort({ order_amount: -1 }).limit(2)

db.delivery_partners.find().sort({ rating: -1 })

db.customers.updateOne(
  { customer_id: 1 },
  { $set: { membership: "Platinum" } }
)

db.restaurants.updateOne(
  { restaurant_id: 104 },
  { $set: { rating: 4.1 } }
)

db.orders.updateOne(
  { order_id: 1003 },
  { $set: { order_status: "Delivered" } }
)

db.orders.updateOne(
  { order_id: 1003 },
  { $set: { delivery_time_minutes: 45 } }
)

db.customers.updateMany(
  {},
  { $set: { active: true } }
)

db.customers.updateMany(
  {},
  { $unset: { active: "" } }
)

db.orders.updateOne(
  { order_id: 1006 },
  {
    $push: {
      items: {
        item_name: "Curd Rice",
        quantity: 1,
        price: 120
      }
    }
  }
)

db.orders.deleteMany({
  order_status: "Cancelled"
})

db.restaurants.deleteMany({
  rating: { $lt: 4.0 }
})

db.customers.countDocuments()

db.orders.countDocuments()

db.orders.countDocuments({
  order_status: "Delivered"
})

db.orders.countDocuments({
  "payment.status": "Failed"
})

db.customers.distinct("city")

db.restaurants.distinct("cuisine")

db.orders.distinct("payment.mode")

db.orders.aggregate([
  {
    $group: {
      _id: "$payment.mode",
      totalRevenue: { $sum: "$order_amount" }
    }
  }
])

db.orders.aggregate([
  {
    $group: {
      _id: "$order_status",
      totalRevenue: { $sum: "$order_amount" }
    }
  }
])

db.orders.aggregate([
  {
    $match: {
      order_status: "Delivered",
      delivery_time_minutes: { $ne: null }
    }
  },
  {
    $group: {
      _id: null,
      averageDeliveryTime: {
        $avg: "$delivery_time_minutes"
      }
    }
  }
])

db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      totalOrders: { $sum: 1 },
      totalAmount: { $sum: "$order_amount" }
    }
  }
])

db.orders.aggregate([
  {
    $group: {
      _id: "$restaurant_id",
      totalOrders: { $sum: 1 },
      totalRevenue: { $sum: "$order_amount" }
    }
  }
])

db.orders.aggregate([
  {
    $match: {
      order_rating: { $ne: null }
    }
  },
  {
    $group: {
      _id: "$restaurant_id",
      averageOrderRating: {
        $avg: "$order_rating"
      }
    }
  }
])

db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      totalSpending: {
        $sum: "$order_amount"
      }
    }
  },
  {
    $match: {
      totalSpending: { $gt: 700 }
    }
  }
])

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $project: {
      _id: 0,
      order_id: 1,
      customer_name: "$customer.name",
      city: "$customer.city",
      order_amount: 1,
      order_status: 1
    }
  }
])

db.orders.aggregate([
  {
    $lookup: {
      from: "restaurants",
      localField: "restaurant_id",
      foreignField: "restaurant_id",
      as: "restaurant"
    }
  },
  {
    $unwind: "$restaurant"
  },
  {
    $project: {
      _id: 0,
      order_id: 1,
      restaurant_name: "$restaurant.name",
      cuisine: "$restaurant.cuisine",
      order_amount: 1
    }
  }
])

db.orders.aggregate([
  {
    $lookup: {
      from: "delivery_partners",
      localField: "partner_id",
      foreignField: "partner_id",
      as: "partner"
    }
  },
  {
    $unwind: {
      path: "$partner",
      preserveNullAndEmptyArrays: true
    }
  },
  {
    $project: {
      _id: 0,
      order_id: 1,
      partner_name: "$partner.partner_name",
      delivery_time_minutes: 1,
      order_status: 1
    }
  }
])

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer"
    }
  },
  {
    $lookup: {
      from: "restaurants",
      localField: "restaurant_id",
      foreignField: "restaurant_id",
      as: "restaurant"
    }
  },
  {
    $lookup: {
      from: "delivery_partners",
      localField: "partner_id",
      foreignField: "partner_id",
      as: "partner"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $unwind: "$restaurant"
  },
  {
    $unwind: {
      path: "$partner",
      preserveNullAndEmptyArrays: true
    }
  },
  {
    $project: {
      _id: 0,
      order_id: 1,
      customer_name: "$customer.name",
      restaurant_name: "$restaurant.name",
      cuisine: "$restaurant.cuisine",
      partner_name: "$partner.partner_name",
      order_amount: 1,
      payment_mode: "$payment.mode",
      payment_status: "$payment.status",
      order_status: 1,
      delivery_time_minutes: 1,
      order_rating: 1
    }
  }
])
