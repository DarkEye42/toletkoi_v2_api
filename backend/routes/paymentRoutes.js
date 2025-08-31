const express = require('express');
const router = express.Router();
const Payment = require('../models/payment');
const Promotion = require('../models/promotion');
const auth = require('../middleware/auth');

// Create payment (stub for Stripe/SSLCOMMERZ)
router.post('/init', auth, async (req, res) => {
  // TODO: Integrate with Stripe/SSLCOMMERZ
  const paymentId = await Payment.create(req.body);
  res.json({ ok: true, paymentId });
});

// IPN/webhook stub
router.post('/ipn', async (req, res) => {
  // TODO: Handle payment notification
  res.json({ ok: true });
});

// Promotion creation
router.post('/promote', auth, async (req, res) => {
  const promoId = await Promotion.create(req.body);
  res.json({ ok: true, promoId });
});

module.exports = router;
