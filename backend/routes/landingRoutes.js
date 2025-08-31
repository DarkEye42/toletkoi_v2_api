const express = require('express');
const router = express.Router();
const LandingPage = require('../models/landingPage');

// Public API: get landing message as JSON
router.get('/', (req, res) => {
  const message = LandingPage.getMessage();
  res.json({ message });
});

// Admin: update landing message
router.post('/admin', (req, res) => {
  const { message } = req.body;
  if (!message) return res.status(400).json({ error: 'Message required' });
  LandingPage.setMessage(message);
  res.json({ ok: true, message });
});

module.exports = router;
