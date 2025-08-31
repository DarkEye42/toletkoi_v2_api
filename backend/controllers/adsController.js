const db = require('../config/db');
exports.create = async (req,res)=>{
  const d = req.body;
  try{
    const [r] = await db.query(
      `INSERT INTO rental_posts (uniqueId, post_owner, description, category, takeOver, shortAddress, street, house_no, policeStation, district, division, cost, negotiable, cost_type, building_type, floorSize, contact, date, latitude, longitude, electricity, water, gas, internet, ac, elevator, cc_camera, floorLevel, rooms, bathroom, balcony, kitchen, parking, security, electricity_bill, gas_bill, water_bill, lift_bill, security_bill, active)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
      [d.uniqueId, d.post_owner, d.description, d.category, d.takeOver, d.shortAddress, d.street, d.house_no, d.policeStation, d.district, d.division, d.cost, d.negotiable, d.cost_type, d.building_type, d.floorSize, d.contact, d.date, d.latitude, d.longitude, d.electricity, d.water, d.gas, d.internet, d.ac, d.elevator, d.cc_camera, d.floorLevel, d.rooms, d.bathroom, d.balcony, d.kitchen, d.parking, d.security, d.electricity_bill, d.gas_bill, d.water_bill, d.lift_bill, d.security_bill, d.active]
    );
    res.json({ok:true,id:r.insertId});
  }catch(e){ res.status(500).json({error:e.message}); }
};
exports.getBySlug = async (req,res)=>{
  const slug = req.params.slug;
  const [rows] = await db.query('SELECT rp.*, u.username as owner FROM rental_posts rp JOIN users u ON u.id=rp.post_owner WHERE rp.uniqueId=? OR rp.slug=? LIMIT 1',[slug, slug]);
  if(!rows.length) return res.status(404).json({error:'Not found'});
  const ad = rows[0];
  const [photos] = await db.query('SELECT path FROM ad_photos WHERE ads_id=? ORDER BY sort_order',[ad.id]);
  ad.photos = photos.map(p=>p.path);
  res.json(ad);
};
exports.trackView = async (req,res)=>{
  const id = req.params.id;
  const ip = req.ip;
  await db.query('INSERT INTO ad_views (ad_id, ip) VALUES (?,?)',[id,ip]);
  res.json({ok:true});
};
