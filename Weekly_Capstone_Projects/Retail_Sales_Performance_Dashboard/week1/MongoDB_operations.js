use("retail_dashboard");

db.createCollection("campaign_feedback");

db.campaign_feedback.insertMany([
  {
    store_id: 1,
    region: "South",
    campaign_name: "Summer Electronics Sale",
    product_id: 1,
    feedback: "Strong customer turnout, stock ran low by evening.",
    notes: "Consider increasing inventory for next campaign.",
    rating: 4.6
  },
  {
    store_id: 2,
    region: "West",
    campaign_name: "Apparel Fest",
    product_id: 2,
    feedback: "Moderate response, footfall lower than expected.",
    notes: "Promotion timing overlapped with local holiday.",
    rating: 3.2
  },
  {
    store_id: 3,
    region: "North",
    campaign_name: "Home Essentials Week",
    product_id: 3,
    feedback: "High return rate on ceramic mugs due to packaging damage.",
    notes: "Escalate packaging issue to logistics team.",
    rating: 2.5
  }
]);

db.campaign_feedback.find({ region: "South" });

db.campaign_feedback.updateOne(
  { store_id: 2, campaign_name: "Apparel Fest" },
  { $set: { rating: 3.5 } }
);

db.campaign_feedback.deleteOne({ store_id: 3, rating: { $lt: 2.6 } });

db.campaign_feedback.createIndex({ product_id: 1 });
db.campaign_feedback.createIndex({ region: 1 });

db.campaign_feedback.find().sort({ rating: -1 });
