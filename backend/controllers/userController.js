const db = require('../config/db');
exports.register = async (req,res)=>{
  const {
    unique_id, username, first_name, last_name, profession, company, email, phone, password, nidNumber, birthDate, gander, aboutMe, avatar, joinDate, village, policeStation, district, division, zipCode, latitude, longitude, isUpdated, isRenter, isVerified, is_email_verified, adminPower, adminId, balance, is_owner, last_seen
  } = req.body;
  try{
    const [r] = await db.query(
      `INSERT INTO users (unique_id, username, first_name, last_name, profession, company, email, phone, password, nidNumber, birthDate, gander, aboutMe, avatar, joinDate, village, policeStation, district, division, zipCode, latitude, longitude, isUpdated, isRenter, isVerified, is_email_verified, adminPower, adminId, balance, is_owner, last_seen)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
      [unique_id, username, first_name, last_name, profession, company, email, phone, password, nidNumber, birthDate, gander, aboutMe, avatar, joinDate, village, policeStation, district, division, zipCode, latitude, longitude, isUpdated, isRenter, isVerified, is_email_verified, adminPower, adminId, balance, is_owner, last_seen]
    );
    res.json({id:r.insertId, ok:true});
  }catch(e){ res.status(500).json({error:e.message}); }
};
exports.login = async (req,res)=>{
  const {email,password} = req.body;
  const [rows] = await db.query('SELECT * FROM users WHERE email=? LIMIT 1',[email]);
  if(!rows.length) return res.status(401).json({error:'Invalid'});
  const user = rows[0];
  if(user.password !== password) return res.status(401).json({error:'Invalid'});
  // Remove password from response
  delete user.password;
  res.json({ok:true, user});
};
exports.profile = async (req,res)=>{
  const idOrSlug = req.params.idOrSlug;
  let q = 'SELECT * FROM users WHERE id=? LIMIT 1'; let params=[idOrSlug];
  if(isNaN(parseInt(idOrSlug))){ q='SELECT * FROM users WHERE username=? LIMIT 1'; params=[idOrSlug]; }
  const [rows] = await db.query(q, params);
  if(!rows.length) return res.status(404).json({error:'Not found'});
  const user = rows[0];
  delete user.password;
  res.json(user);
};
exports.switchRole = async (req,res)=>{
  const {userId, roleId} = req.body;
  await db.query('UPDATE users SET role_id=? WHERE id=?',[roleId,userId]);
  res.json({ok:true});
};
