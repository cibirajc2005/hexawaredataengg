use("attendance_tracker");

db.createCollection("task_feedback");

db.task_feedback.insertMany([
  {
    employee_id: 1,
    department: "Engineering",
    date: "2026-06-01",
    feedback: "Completed API development ahead of schedule.",
    notes: "Showed strong ownership on debugging production issue.",
    rating: 4.5
  },
  {
    employee_id: 2,
    department: "HR",
    date: "2026-06-01",
    feedback: "Recruitment drive went smoothly.",
    notes: "Needs to improve follow-up time with candidates.",
    rating: 3.8
  },
  {
    employee_id: 3,
    department: "Sales",
    date: "2026-06-01",
    feedback: "Absent, no client follow-up completed.",
    notes: "Third absence this month, flagged for HR review.",
    rating: 2.0
  }
]);

db.task_feedback.find({ department: "Engineering" });

db.task_feedback.updateOne(
  { employee_id: 2, date: "2026-06-01" },
  { $set: { rating: 4.0 } }
);

db.task_feedback.deleteOne({ employee_id: 3, rating: { $lt: 2.5 } });

db.task_feedback.createIndex({ employee_id: 1 });
db.task_feedback.createIndex({ department: 1 });

db.task_feedback.find().sort({ rating: -1 });
