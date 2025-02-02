import Car from '../models/car.js';

export const getAllCars = async (req, res) => {
  try {
    const cars = await Car.find();
    res.json(cars);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};

// get car by make
export const getCarsByMake = async (req, res) => {
  try {
    const cars = await Car.find({ make: req.params });
    res.json(cars);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};

export const getCarById = async (req, res) => {
  try {
    const car = await Car.findById(req.params.id);
    if (!car) {
      return res.status(404).json({ message: 'Car not found' });
    }
    res.json(car);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};

export const addCar = async (req, res) => {
  try {
    const car = new Car(req.body);
    await car.save();
    res.status(201).json(car);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
};
