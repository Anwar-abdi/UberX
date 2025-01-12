import mongoose from 'mongoose';

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
      enum: ['SUV', 'Sedan', 'Sports', 'Luxury'],
    },
    pricePerDay: {
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
      enum: ['Automatic', 'Manual'],
    },
    fuelType: {
      type: String,
      required: true,
    },
    available: {
      type: Boolean,
      default: true,
    },
    images: [
      {
        type: String,
      },
    ],
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('Car', carSchema);
