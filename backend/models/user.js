const db = require('../config/db');

const User = {
  async findByEmail(email) {
    const [rows] = await db.query('SELECT * FROM users WHERE email=? LIMIT 1', [email]);
    return rows[0];
  },
  async findById(id) {
    const [rows] = await db.query('SELECT * FROM users WHERE id=? LIMIT 1', [id]);
    return rows[0];
  },
  async create(user) {
    const keys = Object.keys(user);
    const values = Object.values(user);
    const placeholders = keys.map(() => '?').join(',');
    const [r] = await db.query(`INSERT INTO users (${keys.join(',')}) VALUES (${placeholders})`, values);
    return r.insertId;
  },
  async update(id, fields) {
    const keys = Object.keys(fields);
    const values = Object.values(fields);
    const set = keys.map(k => `${k}=?`).join(',');
    await db.query(`UPDATE users SET ${set} WHERE id=?`, [...values, id]);
  }
};

module.exports = User;
