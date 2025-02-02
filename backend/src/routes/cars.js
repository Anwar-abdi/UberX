import express from 'express';
import Car from '../models/car.js';
import auth from '../middleware/auth.js';

const router = express.Router();

// Get all cars
router.get('/', async (req, res) => {
  try {
    const cars = await Car.find();
    res.json(cars);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Get single car
router.get('/:id', async (req, res) => {
  try {
    const car = await Car.findById(req.params.id);
    if (!car) {
      return res.status(404).json({ message: 'Car not found' });
    }
    res.json(car);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Add new car (admin only)
router.post('/', async (req, res) => {
  try {
    const car = new Car(req.body);
    await car.save();
    res.status(201).json(car);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// get cars by make
router.get('/make/:make', async (req, res) => {
  try {
    const cars = await Car.find({ make: req.params.make });
    res.json(cars);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

export default router;
