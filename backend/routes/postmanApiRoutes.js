const express = require('express');
const fs = require('fs');
const path = require('path');
const router = express.Router();

router.get('/', (req, res) => {
  const filePath = path.join(__dirname, '../postman/toletkoi_postman_collection_v3.json');
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) return res.status(500).json({ error: 'File not found' });
    res.setHeader('Content-Type', 'application/json');
    res.send(data);
  });
});

module.exports = router;
