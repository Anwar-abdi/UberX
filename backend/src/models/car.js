import mongoose from "mongoose";

const carSchema = new mongoose.Schema(
  {
    make: {
      type: String,
      required: true,
    },
    model: {
      type: String,
      required: true,
    },
    year: {
      type: Number,
      required: true,
    },
    type: {
      type: String,
      required: true,
      enum: ["SUV", "Sedan", "Sports", "Luxury"],
    },
    pricePerHour: {
      type: Number,
      required: true,
    },
    seats: {
      type: Number,
      required: true,
    },
    transmission: {
      type: String,
      required: true,
      enum: ["Automatic", "Manual"],
    },
    fuelType: {
      type: String,
      required: true,
    },
    available: {
      type: Boolean,
      default: true,
    },
    image: {
      type: String,
      required: true,
    },
    rating: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("Car", carSchema);
