import express from "express";
import Booking from "../models/Booking.js";
import auth from "../middleware/auth.js";

const router = express.Router();

router.post("/", auth, async (req, res) => {
  try {
    const { car, startDate, endDate, rentType } = req.body;
    const userId = req.user.id;

    const newBooking = new Booking({
      user: userId,
      car,
      startDate,
      endDate,
      rentType,
    });

    await newBooking.save();
    res.status(201).json({ message: "Booking created successfully!" });
  } catch (error) {
    res.status(500).json({ message: "Server error", error });
  }
});

router.put("/:id/status", auth, async (req, res) => {
  try {
    const { status } = req.body;
    if (!["confirmed", "cancelled"].includes(status)) {
      return res.status(400).json({ message: "Invalid status" });
    }

    const booking = await Booking.findById(req.params.id);
    if (!booking) {
      return res.status(404).json({ message: "Booking not found" });
    }

    booking.status = status;
    await booking.save();

    res.json({ message: `Booking ${status}`, booking });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
});

router.get("/my-bookings", auth, async (req, res) => {
  try {
    const bookings = await Booking.find({ user: req.user._id })
      .populate("car")
      .sort({ createdAt: -1 });
    res.json(bookings);
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
});

router.get("/", async (req, res) => {
  try {
    const bookings = await Booking.find()
      .populate("user car")
      .sort({ createdAt: -1 });
    res.json(bookings);
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
});

export default router;
