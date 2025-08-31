const db = require('../config/db');

const UserRole = {
  async getRoles(user_id) {
    const [rows] = await db.query('SELECT * FROM user_roles WHERE user_id=?', [user_id]);
    return rows;
  },
  async setRole(user_id, role) {
    await db.query('INSERT INTO user_roles (user_id, role) VALUES (?, ?) ON DUPLICATE KEY UPDATE role=?', [user_id, role, role]);
  }
};

module.exports = UserRole;
