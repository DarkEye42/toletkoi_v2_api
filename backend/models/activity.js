const db = require('../config/db');

const Activity = {
  async log(user_id, type, entity_id, action) {
    await db.query('INSERT INTO user_activity_log (user_id, action, entity_type, entity_id) VALUES (?, ?, ?, ?)', [user_id, action, type, entity_id]);
  },
  async getRecent(user_id, type, limit=10) {
    const [rows] = await db.query('SELECT * FROM user_activity_log WHERE user_id=? AND entity_type=? ORDER BY created_at DESC LIMIT ?', [user_id, type, limit]);
    return rows;
  }
};

module.exports = Activity;
