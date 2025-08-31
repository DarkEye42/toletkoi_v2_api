const express = require('express');
const router = express.Router();
const UserRole = require('../models/userRole');
const auth = require('../middleware/auth');

// Get roles for a user
router.get('/:userId', auth, async (req, res) => {
  const roles = await UserRole.getRoles(req.params.userId);
  res.json(roles);
});

// Set/update role for a user
router.post('/update', auth, async (req, res) => {
  const { user_id, role } = req.body;
  await UserRole.setRole(user_id, role);
  res.json({ ok: true });
});

module.exports = router;
