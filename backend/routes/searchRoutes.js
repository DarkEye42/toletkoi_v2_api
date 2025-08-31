const express = require('express');
const router = express.Router();
const db = require('../config/db');

// Full-text search across ads, products, blogs
// Search endpoint for property, rentals, hotels, and products
router.get('/', async (req, res) => {
  const q = req.query.q || '';
  const priceMin = req.query.priceMin || 0;
  const priceMax = req.query.priceMax || 99999999;
  const category = req.query.category || '';
  let adsQuery = `SELECT * FROM rental_posts WHERE 1`;
  let adsParams = [];
  if (q) {
    adsQuery += ' AND (description LIKE ? OR category LIKE ? OR shortAddress LIKE ? OR street LIKE ? OR house_no LIKE ?)';
    for (let i = 0; i < 5; i++) adsParams.push(`%${q}%`);
  }
  if (category) {
    adsQuery += ' AND category = ?';
    adsParams.push(category);
  }
  adsQuery += ' AND cost BETWEEN ? AND ?';
  adsParams.push(priceMin, priceMax);
  adsQuery += ' LIMIT 30';

  const [ads] = await db.query(adsQuery, adsParams);

  // Hotels (category = 'hotel')
  const [hotels] = await db.query(
    `SELECT * FROM rental_posts WHERE category = 'hotel' AND (description LIKE ? OR shortAddress LIKE ? OR street LIKE ? OR house_no LIKE ?) LIMIT 20`,
    [`%${q}%`, `%${q}%`, `%${q}%`, `%${q}%`]
  );

  // Products
  const [products] = await db.query(
    `SELECT * FROM products WHERE (title LIKE ? OR description LIKE ? OR category LIKE ?) AND price BETWEEN ? AND ? LIMIT 30`,
    [`%${q}%`, `%${q}%`, `%${q}%`, priceMin, priceMax]
  );

  res.json({ rentals: ads, hotels, products });
});

module.exports = router;
